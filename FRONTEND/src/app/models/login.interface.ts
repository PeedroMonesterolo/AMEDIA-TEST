export interface Login {
    email: string;
    password: string;
}

export interface DatosUsuario {
    autenticado: boolean;
    mensaje: string;
    nombre: string;
    apellido: string;
    email: string;
    tipoUsuario: TipoUsuario;
}

export interface TipoUsuario {
    idTipo: number;
    tipoDesc: string;
}
