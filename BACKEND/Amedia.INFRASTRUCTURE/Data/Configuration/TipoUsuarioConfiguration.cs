using Amedia.CORE.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Amedia.INFRASTRUCTURE.Data.Configuration;

public class TipoUsuarioConfiguration : IEntityTypeConfiguration<TipoUsuario>
{
    public void Configure(EntityTypeBuilder<TipoUsuario> entity)
    {
        entity.HasKey(e => e.IdTipo);

        entity.ToTable("TipoUsuario");

        entity.Property(e => e.IdTipo).HasColumnName("id_tipo");
        entity.Property(e => e.TipoDesc)
            .IsUnicode(false)
            .HasColumnName("tipo_desc");

    }
}
