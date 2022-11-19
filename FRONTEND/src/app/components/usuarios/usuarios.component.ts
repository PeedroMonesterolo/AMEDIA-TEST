import { Component, OnInit, ViewChild } from '@angular/core';
import { UsuarioService } from 'src/app/services/usuario.service';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator, PageEvent } from '@angular/material/paginator';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { Usuario } from 'src/app/models/usuarios.interface';
import { ConfirmDialogComponent } from '../confirm-dialog/confirm-dialog.component';
import { UsuarioDialogComponent } from '../usuario-dialog/usuario-dialog.component';
import { Router } from '@angular/router';

@Component({
  selector: 'app-usuarios',
  templateUrl: './usuarios.component.html',
  styleUrls: ['./usuarios.component.scss']
})
export class UsuariosComponent implements OnInit {
  data!: MatTableDataSource<Usuario>;
  displayedColumns: string[] = [
    'nombre',
    'apellido',
    'email',
    'acciones',
  ];
  @ViewChild(MatPaginator, { static: true }) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;
  pageSize = 10;
  pageSizeOptions: number[] = [5, 10, 25, 100];

  constructor(
    private usuarioService: UsuarioService, 
    public dialog: MatDialog,
    private snackBar: MatSnackBar,
    private router: Router) {
    this.usuarioService.usuariosListSubject.asObservable().subscribe(list => {
      this.data = new MatTableDataSource(list);
      this.data.paginator = this.paginator;
      this.data.sort = this.sort;
    });
    // this.paginator._intl.itemsPerPageLabel = 'Items por pagina:';
    this.usuarioService.usuarioSubject.asObservable().subscribe(data => {
      if (!data) {
        this.router.navigate(['/login']);
      }
    });
  }

  ngOnInit(): void {
    this.usuarioService.getUsuarios().subscribe();
  }

  deleteUser(id: number) {
    const dialogRef = this.dialog.open(ConfirmDialogComponent);

    dialogRef.afterClosed().subscribe((result) => {
      if (result) {
        this.usuarioService.deleteUsuario(id).subscribe((data) => {
          this.usuarioService.getUsuarios().subscribe();
          this.snackBar.open('Usuario eliminado correctamente.');
        });
      }
    });
  }

  editUser(usuario: Usuario) {
    const dialogRef = this.dialog.open(UsuarioDialogComponent, {
      maxWidth: '50vw',
      data: {
        title: 'Editar Usuario',
        usuario,
      },
    });

    dialogRef.afterClosed().subscribe((result) => {
      if (result) {
        this.usuarioService
          .putUsuario(usuario.idUsuario!, result)
          .subscribe((data) => {
            this.usuarioService.getUsuarios().subscribe();
            this.snackBar.open('Usuario actualizado correctamente', 'OK');
          });
      }
    });
  }

  newUser() {
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
          this.usuarioService.getUsuarios().subscribe();
          this.snackBar.open('Usuario creado correctamente.', 'OK');
        });
      }
    });
  }
}
