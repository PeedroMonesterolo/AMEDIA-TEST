using Amedia.CORE.Entities;
using System.ComponentModel.DataAnnotations;

namespace Amedia.WEBAPI.Dtos
{
    public class UsuarioDto
    {
        public int IdUsuario { get; set; }

        public string Nombre { get; set; } = null!;

        public string Apellido { get; set; } = null!;

        public string Email { get; set; } = null!;

        public string Password { get; set; } = null!;

        public int IdTipo { get; set; }
    }
}
