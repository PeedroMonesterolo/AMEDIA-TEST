import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { Router } from '@angular/router';
import { UsuarioService } from 'src/app/services/usuario.service';
import { UsuarioDialogComponent } from '../usuario-dialog/usuario-dialog.component';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  login!: FormGroup;

  constructor(
    private usuarioService: UsuarioService, 
    private router: Router, 
    private snackBar: MatSnackBar ,
    public dialog: MatDialog) {
    const user = JSON.parse(sessionStorage.getItem('usuario')!);

    if (user) {
      this.router.navigate(['/usuarios']);
    }
  }

  ngOnInit(): void {
    this.login = new FormGroup({
      email: new FormControl('', [
        Validators.required,
        Validators.email,
      ]),
      password: new FormControl('', [
        Validators.required,
        Validators.maxLength(35),
      ])
    });
  }

  onLogin() {
    this.usuarioService.Login({ email: this.login.controls['email'].value, password: this.login.controls['password'].value }).subscribe(data => {
      if (!data.autenticado) {
        this.snackBar.open(data.mensaje, 'OK');
        return;
      }

      if (data.tipoUsuario.tipoDesc.toUpperCase() === 'VISITANTE') {
        this.router.navigate(['/visitante']);
      } else {
        this.router.navigate(['/usuarios']);
      }
    })
  }

  register() {
    const dialogRef = this.dialog.open(UsuarioDialogComponent, {
      maxWidth: '50vw',
      data: {
        title: 'Nuevo Usuario',
        usuario: {
          idUsuario: 0,
          nombre: '',
          apellido: '',
          email: '',
          password: '',
          idTipo: 1
        },
      },
    });

    dialogRef.afterClosed().subscribe((result) => {
      if (result) {
        this.usuarioService.Register(result).subscribe((data) => {
          this.snackBar.open('Usuario creado correctamente.', 'OK');
        });
      }
    });

  }

}
