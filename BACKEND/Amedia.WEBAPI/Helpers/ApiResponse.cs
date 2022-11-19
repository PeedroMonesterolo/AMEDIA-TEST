namespace Amedia.WEBAPI.Helpers;

public class ApiResponse
{
    public ApiResponse(int statusCode, string message = null)
    {
        StatusCode = statusCode;
        Message = message ?? GetDefaultMessage(StatusCode);
    }

    private string GetDefaultMessage(int statusCode)
    {
        return statusCode switch
        {
            400 => "Has realizado una peticion incorrecta.",
            401 => "Usuario no autorizado.",
            404 => "El recurso que has intentado solicitar no existe.",
            405 => "Este metodo HTTP no esta permitido en el servidor.",
            500 => "Error en el servidor. Comunicate con el administrador."
        };
    }

    public int StatusCode { get; set; }
    public string Message { get; set; }
}