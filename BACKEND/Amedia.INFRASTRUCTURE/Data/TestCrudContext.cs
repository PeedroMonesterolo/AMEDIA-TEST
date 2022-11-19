using Amedia.CORE.Entities;
using Microsoft.EntityFrameworkCore;
using System.Reflection;

namespace Amedia.CORE;

public partial class TestCrudContext : DbContext
{
    public TestCrudContext()
    {
    }

    public TestCrudContext(DbContextOptions<TestCrudContext> options)
        : base(options)
    {
    }

    public virtual DbSet<TipoUsuario> TipoUsuarios { get; set; }

    public virtual DbSet<Usuario> Usuarios { get; set; }


    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());
    }
}
