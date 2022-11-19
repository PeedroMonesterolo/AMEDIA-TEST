using System.ComponentModel.DataAnnotations;

namespace Amedia.WEBAPI.Dtos;

public class LoginDto
{
    [Required(ErrorMessage = "El email es requerido")]
    [EmailAddress(ErrorMessage = "Correo electronico con formato invalido")]
    public string email { get; set; }
    [Required(ErrorMessage = "La contraseña es requerida")]
    public string password { get; set; }
}
