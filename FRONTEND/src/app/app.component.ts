import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { UsuarioService } from './services/usuario.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'testcrud-angular';
  autenticado = false;
  tipo: string = '';

  constructor(private usuarioService: UsuarioService, private router: Router) {
    this.usuarioService.usuarioSubject.asObservable().subscribe(data => {
      this.autenticado = data?.autenticado!
      this.tipo = data?.tipoUsuario.tipoDesc.toUpperCase()!;
    });
  }

  onLogout() {
    sessionStorage.clear();
    this.usuarioService.usuarioSubject.next(null);
    this.router.navigate(['/login']);
  }
}
