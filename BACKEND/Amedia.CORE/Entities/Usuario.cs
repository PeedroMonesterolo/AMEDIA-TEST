using System;
using System.Collections.Generic;

namespace Amedia.CORE.Entities;

public class Usuario
{
    public int IdUsuario { get; set; }

    public string Nombre { get; set; } = null!;

    public string Apellido { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Password { get; set; } = null!;

    public int IdTipo { get; set; }
}
