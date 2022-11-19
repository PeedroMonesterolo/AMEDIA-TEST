import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { UsuarioService } from 'src/app/services/usuario.service';

@Component({
  selector: 'app-visitante',
  templateUrl: './visitante.component.html',
  styleUrls: ['./visitante.component.scss']
})
export class VisitanteComponent implements OnInit {
  nombre: string = '';
  constructor(
    private usuarioService: UsuarioService,
    private router: Router
  ) {
    this.usuarioService.usuarioSubject.asObservable().subscribe(data => this.nombre = `${data?.apellido}, ${data?.nombre}`);
    this.usuarioService.usuarioSubject.asObservable().subscribe(data => {
      if (!data) {
        this.router.navigate(['/login']);
      }
    });
  }

  ngOnInit(): void {
  }

}
