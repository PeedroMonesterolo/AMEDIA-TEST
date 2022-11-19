using Amedia.CORE;
using Amedia.CORE.Entities;
using Amedia.CORE.Interfaces;
using Amedia.INFRASTRUCTURE.Repositories.Generic;
using Microsoft.EntityFrameworkCore;

namespace Amedia.INFRASTRUCTURE.Repositories;

public class UsuarioRepository : GenericRepository<Usuario>, IUsuarioRepository
{
    public UsuarioRepository(TestCrudContext context) : base(context)
    {
    }

    public async Task<IEnumerable<Usuario>> ExistingUser(string email) =>
        await _context.Usuarios.Where(p => p.Email == email).ToListAsync();

    public async Task<Usuario> GetByEmailAsync(string email)
    {
        return await _context.Usuarios.Where(p => p.Email == email).FirstOrDefaultAsync();
    }
}
