import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class TipoUsuarioService {

  constructor(private http: HttpClient) { }

  getTiposUsuarios(): Observable<any> {
    return this.http
      .get<any>(`${environment.urlApi}/TipoUsuarios`);
  }
}
