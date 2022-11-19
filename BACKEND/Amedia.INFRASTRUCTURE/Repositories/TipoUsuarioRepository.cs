using Amedia.CORE;
using Amedia.CORE.Entities;
using Amedia.CORE.Interfaces;
using Amedia.INFRASTRUCTURE.Repositories.Generic;

namespace Amedia.INFRASTRUCTURE.Repositories;

public class TipoUsuarioRepository : GenericRepository<TipoUsuario>, ITipoUsuarioRepository
{
    public TipoUsuarioRepository(TestCrudContext context) : base(context)
    {
    }
}
