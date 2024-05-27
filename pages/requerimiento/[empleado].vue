<script setup lang="ts">
definePageMeta({
  layout: "landing",
});
import InputsRequerimiento from '@/components/InputsRequerimiento.vue';
import inputsProcesoRequerimiento from '@/components/inputsProcesoRequerimiento.vue';
const save = () => {
  submit();
};


let salarioMax = ref("")
let salarioMin = ref("")
let nVacantes = ref("")
let descfuncion = ref("")
let descCarreras = ref("")
let FechaReque = ref(null)

const updateSalarioMax = (newVal: any) => {
  salarioMax.value = newVal
}
const updateNVacantes = (newVal: any) => {
  nVacantes.value = newVal
}
const updateDescfuncion = (newVal: any) => {
  descfuncion.value = newVal
}
const updateDescCarreras = (newVal: any) => {
  descCarreras.value = newVal
}
const updateFechaReque = (newVal: any) => {
  FechaReque.value = newVal
}
const updateSalarioMin = (newVal: any) => {
  salarioMin.value = newVal
}

let selectedPerfil = ref(null)
let selectedFase = ref(null)
let convocatoria = ref("")
let invitacion = ref("")
let fechaInicio = ref(null)
let fechaFin = ref(null)

const updateSelectedPerfil = (newVal: any) => {
  selectedPerfil.value = newVal
}
const updateSelectedFase = (newVal: any) => {
  selectedFase.value = newVal
}
const updateConvocatoria = (newVal: any) => {
  convocatoria.value = newVal
}
const updateInvitacion = (newVal: any) => {
  invitacion.value = newVal
}
const updateFechaInicio = (newVal: any) => {
  fechaInicio.value = newVal
}
const updateFechaFin = (newVal: any) => {
  fechaFin.value = newVal
}


let message = ref("");
let create = ref(false);
let alredyCreate = ref(false);
let isIncomplete = ref(false);

async function submit() {
  try {
    if (!salarioMax.value || !salarioMin.value || !FechaReque.value || !descfuncion.value || !descCarreras.value || !nVacantes.value || !selectedPerfil.value || !selectedFase.value || !convocatoria.value || !invitacion.value) {
      message.value = "Faltan datos";
      isIncomplete.value = true;
      return;
    }
    const route = useRoute();
    await $fetch('/requerimientos/' + route.params.empleado, {
      method: 'POST',
      body: {
        "FECHAREQUE": FechaReque.value,
        "SALARIOMAX": salarioMax.value,
        "SALARIOMIN": salarioMin.value,
        "DESCFUNCION": descfuncion.value,
        "DESCCARRERAS": descCarreras.value,
        "NVACANTES": nVacantes.value,
        //ProcesoReq
        "IDPERFIL": selectedPerfil.value,
        "IDFASE": selectedFase.value,
        "CONVOCATORIA": convocatoria.value,
        "INVITACION": invitacion.value,
        "FECHAINICIO": fechaInicio.value,
        "FECHAFIN": fechaFin.value
      }
    })
    message.value = "requerimiento creado";
    create.value = true;
  }
  catch (error) {
    console.error('Error during fetch:', error);
    message.value = "Ya existe un requerimiento";
    alredyCreate.value = true;
  }
}
const currentDate = new Date().toLocaleDateString();
</script>

<template>
  <Card class="mt-[5vh]" style="overflow: hidden">
    <template #header>
      <LandingSectionhead>
        <template v-slot:title>Crear Requerimiento</template>
        <template v-slot:desc>We find the best people.<br> fecha: {{ currentDate }}</template>
      </LandingSectionhead>
    </template>
    <template #content>
      <InputsRequerimiento propisDisable=false @update:salarioMax="updateSalarioMax"
        @update:salarioMin="updateSalarioMin" @update:nVacantes="updateNVacantes"
        @update:descfuncion="updateDescfuncion" @update:descCarreras="updateDescCarreras"
        @update:FechaReque="updateFechaReque" />
      <inputsProcesoRequerimiento propisDisable=false @update:selectedPerfil="updateSelectedPerfil"
        @update:selectedFase="updateSelectedFase" @update:convocatoria="updateConvocatoria"
        @update:invitacion="updateInvitacion" @update:fechaInicio="updateFechaInicio"
        @update:fechaFin="updateFechaFin" />
    </template>
    <template #footer>
      <div class="flex justify-center align-middle gap-3 mt-1">
        <Button label="Save" @click="save" rounded severity="contrast" icon="pi pi-check" iconPos="right"
          class="text-white bg-black px-2 py-2"></Button>
      </div>
    </template>
  </Card>
  <div class="card flex flex-wrap items-center justify-center gap-3 mt-16">
    <InlineMessage v-if="isIncomplete" severity="error">{{ message }}</InlineMessage>
    <InlineMessage v-else-if="alredyCreate" severity="warn">{{ message }}</InlineMessage>
    <InlineMessage v-else-if="create" severity="success">{{ message }}</InlineMessage>
  </div>
</template>