(() => {
  const $ = s => document.querySelector(s);

  const tbody      = $('#tablaRoles tbody');
  const buscarRol  = $('#buscarRol');
  const btnNuevo   = $('#btnNuevoRol');

  const modal      = $('#modalRol');
  const tituloModal= $('#tituloModalRol');
  const form       = $('#formRol');
  const inputId    = $('#IdRol');
  const inputDesc  = $('#DescripcionRol');
  const listaMods  = $('#listaModulosRol');
  const btnCancel  = $('#btnCancelarRol');

  const toast      = document.getElementById('toast');

 
  const modalConfirm = document.getElementById('modalConfirmacion');
  const textoConfirm = document.getElementById('textoConfirmacion');
  const btnSi        = document.getElementById('btnSi');
  const btnNo        = document.getElementById('btnNo');

  let accionConfirmada = null;

  function abrirConfirmacion(mensaje, callback) {
    if (!modalConfirm) {
      if (confirm(mensaje)) callback();
      return;
    }
    textoConfirm.textContent = mensaje;
    accionConfirmada = callback;
    modalConfirm.setAttribute('aria-hidden', 'false');
  }

  function cerrarConfirmacion() {
    if (!modalConfirm) return;
    modalConfirm.setAttribute('aria-hidden', 'true');
    accionConfirmada = null;
  }

  btnNo?.addEventListener('click', cerrarConfirmacion);
  btnSi?.addEventListener('click', () => {
    if (accionConfirmada) accionConfirmada();
    cerrarConfirmacion();
  });

  let roles   = [];
  let modulos = [];

  function showToast(msg, type = 'error') {
    if (!toast) { alert(msg); return; }
    toast.textContent = msg;
    toast.className = 'toast ' + (type === 'success' ? 'success' : 'error');
    toast.style.display = 'block';
    setTimeout(() => { toast.style.display = 'none'; }, 2200);
  }


  function abrirModal() {
    modal.setAttribute('aria-hidden', 'false');
  }
  function cerrarModal() {
    modal.setAttribute('aria-hidden', 'true');
  }
  // ======= RENDERIZADO DE MÓDULOS =======

  function renderCheckboxes(modulosSeleccionados = []) {
    if (!listaMods) return;
    listaMods.innerHTML = '';

    const sel = new Set(modulosSeleccionados.map(Number));

    modulos.forEach(m => {
      const label = document.createElement('label');
      label.className = 'modulo-item';

      const cb = document.createElement('input');
      cb.type  = 'checkbox';
      cb.name  = 'modulos[]';
      cb.value = m.IdModulo;
      if (sel.has(m.IdModulo)) cb.checked = true;

      const span = document.createElement('span');
      span.textContent = m.Titulo;

      label.appendChild(cb);
      label.appendChild(span);
      listaMods.appendChild(label);
    });

    if (!modulos.length) {
      listaMods.innerHTML = '<p>No hay módulos definidos.</p>';
    }
  }

  // ======= CARGA DE DATOS =======
  async function cargarModulos() {
    try {
      const r = await fetch('modulos/roles/listar_modulos.php', {
        credentials: 'same-origin'
      });
      const res = await r.json();
      if (!res.ok) {
        showToast(res.msg || 'No se pudieron cargar los módulos');
        return;
      }
      modulos = res.modulos || [];
      renderCheckboxes([]);
    } catch (e) {
      console.error(e);
      showToast('Error de red al cargar módulos');
    }
  }


  async function cargarRoles() {
    if (!tbody) return;

    tbody.innerHTML = '<tr><td colspan="5">Cargando...</td></tr>';
    try {
      const r = await fetch('modulos/roles/listar.php', {
        credentials: 'same-origin'
      });
      const res = await r.json();
      if (!res.ok) {
        tbody.innerHTML = '<tr><td colspan="5">Error: '+(res.msg || '')+'</td></tr>';
        return;
      }
      roles = res.data || [];
      renderRoles();
    } catch (e) {
      console.error(e);
      tbody.innerHTML = '<tr><td colspan="5">Error de red</td></tr>';
    }
  }

  function renderRoles() {
    const filtro = (buscarRol?.value || '').toLowerCase();
    tbody.innerHTML = '';

    let count = 0;
    roles.forEach(rol => {
      const texto = (rol.Descripcion || '').toLowerCase();
      if (filtro && !texto.includes(filtro)) return;

      const tr = document.createElement('tr');
      tr.innerHTML = `
        <td>${rol.IdRol}</td>
        <td>${rol.Descripcion}</td>
        <td>${rol.NumModulos}</td>
        <td style="text-align:center;">
          <button class="btn-icon btn-edit" title="Editar rol">
            <img src="img/editar.png" alt="Editar">
          </button>
        </td>
        <td style="text-align:center;">
          <button class="btn-icon btn-del" title="Eliminar rol">
            <img src="img/eliminar.png" alt="Eliminar">
          </button>
        </td>
      `;

      tr.querySelector('.btn-edit').onclick = () => editarRol(rol.IdRol);
      tr.querySelector('.btn-del').onclick  = () => eliminarRol(rol.IdRol, rol.Descripcion);

      tbody.appendChild(tr);
      count++;
    });

    if (!count) {
      tbody.innerHTML = '<tr><td colspan="5">No se encontraron roles</td></tr>';
    }
  }

  function nuevoRol() {
    form.reset();
    inputId.value = '';
    tituloModal.textContent = 'Nuevo rol';
    renderCheckboxes([]);
    abrirModal();
  }

  async function editarRol(IdRol) {
    try {
      const r = await fetch('modulos/roles/detalle.php?IdRol=' + encodeURIComponent(IdRol), {
        credentials: 'same-origin'
      });
      const res = await r.json();
      if (!res.ok) {
        showToast(res.msg || 'No se pudo cargar el rol');
        return;
      }

      form.reset();
      inputId.value   = res.rol.IdRol;
      inputDesc.value = res.rol.Descripcion || '';
      tituloModal.textContent = 'Editar rol';

      renderCheckboxes(res.modulos || []);
      abrirModal();

    } catch (e) {
      console.error(e);
      showToast('Error de red al cargar rol');
    }
  }

  async function guardarRol(ev) {
    ev.preventDefault();

    const fd = new FormData(form);

    try {
      const r = await fetch('modulos/roles/guardar.php', {
        method: 'POST',
        body: fd,
        credentials: 'same-origin'
      });
      const res = await r.json();
      if (res.ok) {
        cerrarModal();
        await cargarRoles();
        showToast(res.msg || 'Rol guardado', 'success');
      } else {
        showToast(res.msg || 'No se pudo guardar el rol');
      }
    } catch (e) {
      console.error(e);
      showToast('Error de red al guardar rol');
    }
  }

  function eliminarRol(IdRol, nombre) {
    abrirConfirmacion(`¿Eliminar el rol "${nombre}"?`, () => {
      confirmarEliminarRol(IdRol);
    });
  }

  async function confirmarEliminarRol(IdRol) {
    const fd = new FormData();
    fd.append('IdRol', IdRol);

    try {
      const r = await fetch('modulos/roles/eliminar.php', {
        method: 'POST',
        body: fd,
        credentials: 'same-origin'
      });
      const res = await r.json();
      if (res.ok) {
        await cargarRoles();
        showToast(res.msg || 'Rol eliminado', 'success');
      } else {
        showToast(res.msg || 'No se pudo eliminar el rol');
      }
    } catch (e) {
      console.error(e);
      showToast('Error de red al eliminar rol');
    }
  }


  btnNuevo?.addEventListener('click', nuevoRol);
  btnCancel?.addEventListener('click', cerrarModal);
  form?.addEventListener('submit', guardarRol);
  buscarRol?.addEventListener('input', renderRoles);


  cargarModulos();
  cargarRoles();
})();
