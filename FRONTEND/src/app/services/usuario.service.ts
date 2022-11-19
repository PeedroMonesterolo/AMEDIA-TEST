import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, map, Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { DatosUsuario, Login } from '../models/login.interface';
import { Usuario } from '../models/usuarios.interface';

@Injectable({
  providedIn: 'root'
})
export class UsuarioService {
  public usuarioSubject = new BehaviorSubject<DatosUsuario | null>(JSON.parse(sessionStorage.getItem('usuario')!));
  public usuariosListSubject = new BehaviorSubject<Usuario[] | []>([]);

  constructor(private http: HttpClient) {
   }

  getUsuarios(): Observable<Usuario[]> {
    return this.http
      .get<Usuario[]>(`${environment.urlApi}/Usuarios`)
      .pipe(
        map((data: Usuario[]) => {
          this.usuariosListSubject.next(data);
          return data;
        })
      );
  }

  getUsuarioById(id: number): Observable<any> {
    return this.http.get<any>(
      `${environment.urlApi}/Usuarios/${id}`
    );
  }

  Register(model: any): Observable<any> {
    return this.http.post<any>(
      `${environment.urlApi}/Usuarios/register`, model
    );
  }

  Login(model: Login): Observable<DatosUsuario> {
    return this.http.post<DatosUsuario>(
      `${environment.urlApi}/Usuarios/login`, model
    ).pipe(
      map((data: DatosUsuario) => {
        if (data.autenticado) {
          sessionStorage.setItem('usuario', JSON.stringify(data));
          this.usuarioSubject.next(data);
        }

        return data;
      })
    );;
  }

  putUsuario(id: number, usuario: any): Observable<any> {
    return this.http.put<any>(
      `${environment.urlApi}/Usuarios/${id}`,
      usuario
    );
  }

  deleteUsuario(id: number): Observable<any> {
    return this.http.delete<any>(`${environment.urlApi}/Usuarios/${id}`);
  }
}
