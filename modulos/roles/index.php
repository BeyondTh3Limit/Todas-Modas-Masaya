<?php
session_start();
if (!isset($_SESSION['correo'])) {
  http_response_code(401);
  exit('No autorizado');
}

?>
<div class="vistas-wrapper">

  <h2 class="titulo-principal">Gestión de roles</h2>

  <div class="tabla-card">

    <div class="card-top">
      <button type="button" id="btnNuevoRol" class="btn-nuevo">
        Rol nuevo
      </button>
    </div>

    <div class="card-actions">
      <input type="text" id="buscarRol" class="input-buscar"
             placeholder="Buscar rol por nombre...">
    </div>

    <table class="tabla-vistas" id="tablaRoles">
      <thead>
        <tr>
          <th>ID</th>
          <th>Descripción</th>
          <th >Cant. de módulos asignados</th>
          <th style="text-align:center;">Editar</th>
          <th style="text-align:center;">Eliminar</th>
        </tr>
      </thead>
      <tbody>
        <tr><td colspan="5">No hay roles registrados</td></tr>
      </tbody>
    </table>

  </div>
</div>

<!-- Modal Rol -->
<div class="modal" id="modalRol" aria-hidden="true">
  <div class="modal-content large">
    <div class="modal-header">
      <h3 id="tituloModalRol">Nuevo rol</h3>
    </div>

    <form id="formRol">
      <input type="hidden" name="IdRol" id="IdRol">

      <div class="form-row">
        <div class="icon-slot">
          <img src="img/rol.png" alt="">
        </div>
        <div class="form-field">
          <label for="DescripcionRol">Nombre del rol</label>
          <input type="text" name="Descripcion" id="DescripcionRol" required>
        </div>
      </div>

      <div class="form-row">
        <div class="icon-slot"></div>
        <div class="form-field">
          <label>Módulos a los que tendrá acceso</label>
          <div id="listaModulosRol" class="modulos-grid">
          </div>
        </div>
      </div>

      <div class="modal-actions">
        <button type="button" class="btn-cancelar" id="btnCancelarRol">Cancelar</button>
        <button type="submit" class="btn-guardar">Guardar</button>
      </div>
    </form>
  </div>
</div>

<div id="toast" class="toast" style="display:none;"></div>

<!-- ELIMINAR -->
<div id="modalConfirmacion" class="modal" aria-hidden="true">
  <div class="modal-content small">
    <h3>Confirmar eliminación</h3>
    <p id="textoConfirmacion">¿Está seguro de eliminar este registro?</p>

    <div class="modal-actions" style="justify-content: flex-end;">
      <button type="button" id="btnNo" class="btn-cancelar">No</button>
      <button type="button" id="btnSi" class="btn-eliminar">Sí, eliminar</button>
    </div>
  </div>
</div>



<script src="js/roles.js?v=<?php echo time(); ?>" defer></script>