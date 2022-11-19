using Amedia.CORE.Entities;
using Amedia.CORE.Interfaces.Generic;

namespace Amedia.CORE.Interfaces;

public interface IUsuarioRepository : IGenericRepository<Usuario>
{
    Task<IEnumerable<Usuario>> ExistingUser(string email);
    Task<Usuario> GetByEmailAsync(string username);
}
