using System.ComponentModel.DataAnnotations;

namespace Amedia.WEBAPI.Dtos
{
    public class AddUsuarioDto
    {
        public int? IdUsuario { get; set; }

        [Required(ErrorMessage = "El nombre es requerido")]
        public string Nombre { get; set; }

        [Required(ErrorMessage = "El apellido es requerido")]
        public string Apellido { get; set; }

        [Required(ErrorMessage = "El email es requerido")]
        [EmailAddress(ErrorMessage = "Correo electronico con formato invalido")]
        public string Email { get; set; }

        [Required(ErrorMessage = "La contraseña es requerida")]
        public string Password { get; set; }

        public int IdTipo { get; set; }
    }
}
