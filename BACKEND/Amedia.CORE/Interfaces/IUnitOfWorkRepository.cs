namespace Amedia.CORE.Interfaces;

public interface IUnitOfWorkRepository
{
    IUsuarioRepository Usuarios { get; }
    ITipoUsuarioRepository TipoUsuarios { get; }

    Task<int> SaveAsync();
}
