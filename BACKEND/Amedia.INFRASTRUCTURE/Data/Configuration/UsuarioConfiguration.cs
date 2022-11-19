using Amedia.CORE.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Amedia.INFRASTRUCTURE.Data.Configuration;

internal class UsuarioConfiguration : IEntityTypeConfiguration<Usuario>
{
    public void Configure(EntityTypeBuilder<Usuario> entity)
    {
        entity.HasKey(e => e.IdUsuario);

        entity.Property(e => e.IdUsuario).HasColumnName("id_usuario");
        entity.Property(e => e.Apellido)
            .HasMaxLength(50)
            .IsUnicode(false)
            .HasColumnName("apellido");
        entity.Property(e => e.Email)
            .IsUnicode(false)
            .HasColumnName("email");
        entity.Property(e => e.IdTipo).HasColumnName("id_tipo");
        entity.Property(e => e.Nombre)
            .HasMaxLength(50)
            .IsUnicode(false)
            .HasColumnName("nombre");
        entity.Property(e => e.Password)
            .IsUnicode(false)
            .HasColumnName("password");
    }
}
