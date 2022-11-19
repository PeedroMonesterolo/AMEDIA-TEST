import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TipoUsuario } from 'src/app/models/login.interface';
import { DialogDataUsuario, Usuario } from 'src/app/models/usuarios.interface';
import { TipoUsuarioService } from 'src/app/services/tipo-usuario.service';

@Component({
  selector: 'app-usuario-dialog',
  templateUrl: './usuario-dialog.component.html',
  styleUrls: ['./usuario-dialog.component.scss']
})
export class UsuarioDialogComponent implements OnInit {
  user!: FormGroup;
  tipoUsuario: TipoUsuario[] = [];

  constructor(
    @Inject(MAT_DIALOG_DATA) public data: DialogDataUsuario,
    private tipoUsuarioService: TipoUsuarioService,
    private snackBar: MatSnackBar,
    public dialogRef: MatDialogRef<UsuarioDialogComponent>) {
    this.tipoUsuarioService.getTiposUsuarios().subscribe(data => this.tipoUsuario = data);
    console.log(data);
  }

  ngOnInit(): void {
    this.user = new FormGroup({
      nombre: new FormControl(this.data.usuario.nombre, [
        Validators.required,
        Validators.maxLength(50),
      ]),
      apellido: new FormControl(this.data.usuario.apellido, [
        Validators.required,
        Validators.maxLength(50),
      ]),
      email: new FormControl(this.data.usuario.email, [
        Validators.required,
        Validators.email,
      ]),
      password: new FormControl('', [
        Validators.required,
        Validators.minLength(10),
        Validators.maxLength(20),
      ]),
      idTipo: new FormControl(
        this.data.usuario.idTipo,
        [Validators.required]
      ),
    });
  }

  save() {
    if (this.user.invalid) {
      this.snackBar.open(
        'Error en la carga de datos. Verifique los datos cargados.',
        'OK'
      );
      return;
    }

    const value: Usuario = {
      apellido: this.user.controls['apellido'].value,
      nombre: this.user.controls['nombre'].value,
      email: this.user.controls['email'].value,
      password: this.user.controls['password'].value,
      idTipo: this.user.controls['idTipo'].value,
      idUsuario: this.data.usuario.idUsuario,
    };
    this.dialogRef.close(value);
  }

  soloLetras(event: any) {
    const regex = new RegExp('^[a-zA-Z ]+$');
    const key = String.fromCharCode(
      !event.charCode ? event.which : event.charCode
    );
    if (!regex.test(key)) {
      event.preventDefault();
      return false;
    }
    return true;
  }

  soloNumeros(event: any) {
    let key;
    if (event.type === 'paste') {
      key = event.clipboardData.getData('text/plain');
    } else {
      key = event.keyCode;
      key = String.fromCharCode(key);
    }
    const regex = /[0-9]|\./;
    if (!regex.test(key)) {
      event.returnValue = false;
      if (event.preventDefault) {
        event.preventDefault();
      }
    }
  }
}
