export interface Usuario {
    idUsuario?: number;
    nombre: string;
    apellido: string;
    email: string;
    password: string;
    idTipo: number;
}

export interface DialogDataUsuario {
    title: string;
    usuario: Usuario;
}