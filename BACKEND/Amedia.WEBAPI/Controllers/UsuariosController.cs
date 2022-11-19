using Amedia.CORE.Entities;
using Amedia.CORE.Interfaces;
using Amedia.WEBAPI.Controllers.Base;
using Amedia.WEBAPI.Dtos;
using Amedia.WEBAPI.Helpers;
using AutoMapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace Amedia.WEBAPI.Controllers
{
    public class UsuariosController : BaseApiController
    {
        private readonly IUnitOfWorkRepository _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IPasswordHasher<Usuario> _passwordHasher;
        public UsuariosController(IUnitOfWorkRepository unitOfWork, IMapper mapper, IPasswordHasher<Usuario> passwordHasher)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _passwordHasher = passwordHasher;
        }

        // GET: api/Usuarios
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<IEnumerable<Usuario>>> Get()
        {
            var resultado = await _unitOfWork.Usuarios.GetAllAsync();
            return Ok(resultado);
        }

        // GET api/Usuarios/5
        [HttpGet("{id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<Usuario>> Get(int id)
        {
            var resultado = await _unitOfWork.Usuarios.GetByIdAsync(id);
            return Ok(resultado);
        }

        // POST api/Usuarios/register
        [HttpPost("register")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<Usuario>> Post([FromBody] AddUsuarioDto usuarioDto)
        {
            var existeUsuario = _unitOfWork.Usuarios.ExistingUser(usuarioDto.Email).Result.ToList().Count;
            if (existeUsuario > 0)
                return NotFound(new ApiResponse(404, "El Email ya se encuentra registrado"));

            var usuario = _mapper.Map<Usuario>(usuarioDto);
            usuario.Password = _passwordHasher.HashPassword(usuario, usuario.Password);

            _unitOfWork.Usuarios.Add(usuario);
            await _unitOfWork.SaveAsync();
            if (usuario == null)
                return BadRequest(new ApiResponse(400));

            return CreatedAtAction(nameof(Post), new { id = usuario.IdUsuario }, usuarioDto);
        }

        // POST api/Usuarios/login
        [HttpPost("login")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<DatosUsuarioDto>> Post([FromBody] LoginDto login)
        {
            DatosUsuarioDto datosUsuarioDto = new DatosUsuarioDto();
            var usuario = await _unitOfWork.Usuarios.GetByEmailAsync(login.email);

            if (usuario == null)
            {
                datosUsuarioDto.Autenticado = false;
                datosUsuarioDto.Mensaje = $"No existe ningún usuario con el Email {login.email}.";
                return datosUsuarioDto;
            }

            var resultado = _passwordHasher.VerifyHashedPassword(usuario, usuario.Password, login.password);

            if (resultado == PasswordVerificationResult.Success)
            {
                var tipoUsuario = await _unitOfWork.TipoUsuarios.GetByIdAsync(usuario.IdTipo);

                datosUsuarioDto.Autenticado = true;
                datosUsuarioDto.TipoUsuario = tipoUsuario;
                datosUsuarioDto.Email = usuario.Email;
                datosUsuarioDto.Nombre = usuario.Nombre;
                datosUsuarioDto.Apellido = usuario.Apellido;
                return datosUsuarioDto;
            }

            datosUsuarioDto.Autenticado = false;
            datosUsuarioDto.Mensaje = $"Credenciales incorrectas para el email {usuario.Email}.";
            return datosUsuarioDto;
        }

        // PUT api/Usuarios/5
        [HttpPut("{id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<AddUsuarioDto>> Put(int id, [FromBody] UsuarioDto usuarioDto)
        {
            if (usuarioDto == null)
                return NotFound(new ApiResponse(404, "El usuario solicitado no existe"));

            // Valido si existe el usuario en la base de datos
            var usuarioDb = await _unitOfWork.Usuarios.GetByIdAsync(id);
            if (usuarioDb == null)
                return NotFound(new ApiResponse(404, "El usuario solicitado no existe"));

            var usuario = _mapper.Map<Usuario>(usuarioDto);
            usuario.Password = _passwordHasher.HashPassword(usuario, usuarioDto.Password);

            // ACTUALIZO USUARIO
            _unitOfWork.Usuarios.Update(usuario);
            await _unitOfWork.SaveAsync();
            if (usuario == null)
                return BadRequest(new ApiResponse(400));

            return CreatedAtAction(nameof(Post), new { id = usuario.IdUsuario }, usuarioDto);
        }

        // DELETE api/Usuarios/5
        [HttpDelete("{id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> Delete(int id)
        {
            var usuario = await _unitOfWork.Usuarios.GetByIdAsync(id);
            if (usuario == null)
                return NotFound();

            // Elimino usuario
            _unitOfWork.Usuarios.Remove(usuario);
            await _unitOfWork.SaveAsync();

            return NoContent();
        }
    }
}
