using Amedia.CORE.Entities;

namespace Amedia.WEBAPI.Dtos
{
    public class DatosUsuarioDto
    {
        public bool Autenticado { get; set; }
        public string Mensaje { get; set; }
        public string Nombre { get; set; }

        public string Apellido { get; set; }

        public string Email { get; set; }

        public TipoUsuario TipoUsuario { get; set; }
    }
}
