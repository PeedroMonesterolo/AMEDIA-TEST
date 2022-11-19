using Amedia.CORE.Entities;
using Amedia.WEBAPI.Dtos;
using AutoMapper;

namespace Amedia.WEBAPI.Profiles;

public class MappingProfiles : Profile
{
    public MappingProfiles()
    {
        CreateMap<Usuario, AddUsuarioDto>().ReverseMap();
        CreateMap<Usuario, UsuarioDto>().ReverseMap();
    }
}
