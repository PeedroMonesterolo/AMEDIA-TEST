using Amedia.CORE.Entities;
using Amedia.CORE.Interfaces;
using Amedia.INFRASTRUCTURE.UnitOfWork;
using Amedia.WEBAPI.Controllers.Base;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;

namespace Amedia.WEBAPI.Controllers
{
    public class TipoUsuariosController : BaseApiController
    {
        private readonly IUnitOfWorkRepository _unitOfWork;
        private readonly IMapper _mapper;
        public TipoUsuariosController(IUnitOfWorkRepository unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }

        // GET: api/<TipoUsuariosController>
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<IEnumerable<TipoUsuario>>> Get()
        {
            var resultado = await _unitOfWork.TipoUsuarios.GetAllAsync();
            return Ok(resultado);
        }
    }
}
