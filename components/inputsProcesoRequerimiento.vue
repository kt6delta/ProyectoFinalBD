<script setup lang="ts">
import { ref, watch, defineEmits, watchEffect, defineExpose } from 'vue'

const props = defineProps({
    PropisDisable2: Boolean,
    PropselectedPerfil: Object,
    PropselectedFase: Object,
    Propconvocatoria: String,
    Propinvitacion: String,
    PropfechaInicio: String,
    PropfechaFin: String
});

const selectedPerfil = ref(props.PropselectedPerfil || null);
let idPerfil = ref([await $fetch('/requerimientos/perfil')]);
idPerfil = idPerfil.value[0] as any;

const selectedFase = ref(props.PropselectedFase || null);
let idFase = ref([await $fetch('/requerimientos/fase')]);
idFase = idFase.value[0] as any;

let convocatoria = ref(props.Propconvocatoria || "")
let invitacion = ref(props.Propinvitacion || "")
let fechaInicio = ref(formattedFecha(props.PropfechaInicio) || null)
let fechaFin = ref(formattedFecha(props.PropfechaFin) || null)

const emit = defineEmits(['update:selectedPerfil', 'update:selectedFase', 'update:convocatoria', 'update:invitacion', 'update:fechaInicio', 'update:fechaFin'])

watch(selectedPerfil, (newVal) => {
    emit('update:selectedPerfil', newVal)
})

watch(selectedFase, (newVal) => {
    emit('update:selectedFase', newVal)
})

watch(convocatoria, (newVal) => {
    emit('update:convocatoria', newVal)
})

watch(invitacion, (newVal) => {
    emit('update:invitacion', newVal)
})

watch(fechaInicio, (newVal) => {
    emit('update:fechaInicio', newVal)
})

watch(fechaFin, (newVal) => {
    emit('update:fechaFin', newVal)
})

let isDisable = ref()

watchEffect(() => {
    isDisable.value = props.PropisDisable2
})

function formattedFecha(fecha: any) {
    let date = new Date(fecha);
    let day = ("0" + date.getDate()).slice(-2);
    let month = ("0" + (date.getMonth() + 1)).slice(-2);
    let year = date.getFullYear().toString().substr(-2);
    if (`${day}/${month}/${year}` == "aN/aN/aN") {
        return "";
    } else {
        return `${day}/${month}/${year}`;
    }
}

async function put(CodReq: string) {
    if (selectedPerfil.value && selectedFase.value) {
        await $fetch(`/requerimientos/proceso`, {
            method: 'PUT',
            body: {
                "CONSECREQUE": CodReq,
                "IDPERFIL": selectedPerfil.value.IDPERFIL,
                "IDFASE": selectedFase.value.IDFASE,
                "CONVOCATORIA": convocatoria.value,
                "INVITACION": invitacion.value,
                "FECHAINICIO": formattedFecha(fechaInicio.value),
                "FECHAFIN": formattedFecha(fechaFin.value)
            }
        })
    }
}
defineExpose({
    put
})
</script>

<template>
    <div class="grid md:grid-cols-2 gap-10 mx-auto max-w-4xl mt-10">
        <InputGroup>
            <InputGroupAddon class="bg-black text-white">
                <Icon name="mdi:company" color="white" size="22" />
            </InputGroupAddon>
            <Dropdown v-model="selectedPerfil" :options="idPerfil" optionLabel="DESCPERFIL" placeholder="Perfil"
                class="w-full md:w-[14rem]" :disabled="isDisable" />
        </InputGroup>

        <InputGroup>
            <InputGroupAddon class="bg-black text-white">
                <Icon name="mdi:company" color="white" size="22" />
            </InputGroupAddon>
            <Dropdown v-model="selectedFase" :options="idFase" optionLabel="DESCFASE" placeholder="Fase"
                class="w-full md:w-[14rem]" :disabled="isDisable" />
        </InputGroup>

        <div class="card flex flex-col md:flex-row gap-3">
            <InputGroup>
                <InputGroupAddon class="bg-black text-white">
                    <Icon name="majesticons:calendar" color="white" size="22" />
                </InputGroupAddon>
                <FloatLabel>
                    <label for="label-nacimiento"> Inicio </label>
                    <Calendar dateFormat="dd/mm/yy" v-model="fechaInicio" :disabled="isDisable" />
                </FloatLabel>
            </InputGroup>
        </div>

        <div class="card flex flex-col md:flex-row gap-3">
            <InputGroup>
                <InputGroupAddon class="bg-black text-white">
                    <Icon name="majesticons:calendar" color="white" size="22" />
                </InputGroupAddon>
                <FloatLabel>
                    <label for="label-nacimiento"> Fin </label>
                    <Calendar dateFormat="dd/mm/yy" v-model="fechaFin" :disabled="isDisable" />
                </FloatLabel>
            </InputGroup>
        </div>

        <FloatLabel>
            <Textarea v-model="convocatoria" rows="5" cols="30" :disabled="isDisable" />
            <label>Convocatoria</label>
        </FloatLabel>

        <FloatLabel>
            <Textarea v-model="invitacion" rows="5" cols="30" :disabled="isDisable" />
            <label>Invitacion</label>
        </FloatLabel>
    </div>
</template>