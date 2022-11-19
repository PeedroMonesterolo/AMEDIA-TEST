using Amedia.CORE;
using Amedia.CORE.Interfaces;
using Amedia.INFRASTRUCTURE.Repositories;

namespace Amedia.INFRASTRUCTURE.UnitOfWork;

public class UnitOfWork : IUnitOfWorkRepository, IDisposable
{
    private readonly TestCrudContext _context;
    private IUsuarioRepository _usuario;
    private ITipoUsuarioRepository _tipoUsuario;

    public UnitOfWork(TestCrudContext context)
    {
        _context = context;
    }

    public IUsuarioRepository Usuarios
    {
        get
        {
            if (_usuario == null)
            {
                _usuario = new UsuarioRepository(_context);
            }
            return _usuario;
        }
    }

    public ITipoUsuarioRepository TipoUsuarios
    {
        get
        {
            if (_tipoUsuario == null)
            {
                _tipoUsuario = new TipoUsuarioRepository(_context);
            }
            return _tipoUsuario;
        }
    }

    public void Dispose()
    {
        _context.Dispose();
    }

    public async Task<int> SaveAsync()
    {
        return await _context.SaveChangesAsync();
    }
}
