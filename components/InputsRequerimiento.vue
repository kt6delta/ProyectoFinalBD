<script setup lang="ts">
import { ref, watch, defineEmits, watchEffect } from 'vue'

const props = defineProps({
    PropisDisable: Boolean,
    PropSalarioMax: Number,
    PropSalarioMin: Number,
    PropNVacantes: Number,
    PropDescfuncion: String,
    PropDescCarreras: String,
    PropFechaReque: Date
});
let salarioMax = ref(props.PropSalarioMax || "")
let salarioMin = ref(props.PropSalarioMin || "")
let nVacantes = ref(props.PropNVacantes || "")
let descfuncion = ref(props.PropDescfuncion || "")
let descCarreras = ref(props.PropDescCarreras || "")
let FechaReque = ref(formattedFecha(props.PropFechaReque) || null)

const emit = defineEmits(['update:cod', 'update:salarioMax', 'update:salarioMin', 'update:nVacantes', 'update:descfuncion', 'update:descCarreras', 'update:FechaReque'])

watch(salarioMax, (newVal) => {
    emit('update:salarioMax', newVal)
})

watch(salarioMin, (newVal) => {
    emit('update:salarioMin', newVal)
})

watch(nVacantes, (newVal) => {
    emit('update:nVacantes', newVal)
})

watch(descfuncion, (newVal) => {
    emit('update:descfuncion', newVal)
})

watch(descCarreras, (newVal) => {
    emit('update:descCarreras', newVal)
})

watch(FechaReque, (newVal) => {
    emit('update:FechaReque', newVal)
})

let isDisable = ref(props.PropisDisable)

watchEffect(() => {
    isDisable.value = props.PropisDisable
})

function put() {

}
function delet() {

}
function formattedFecha(fecha: any) {
    let date = new Date(fecha);
    let day = ("0" + date.getDate()).slice(-2);
    let month = ("0" + (date.getMonth() + 1)).slice(-2);
    let year = date.getFullYear().toString().substr(-2);
    return `${day}/${month}/${year}`;
}
</script>

<template>
    <div class="grid md:grid-cols-2 gap-10 mx-auto max-w-4xl">
        <InputGroup>
            <InputGroupAddon class="bg-black text-white">
                <Icon name="material-symbols:person-outline" color="white" size="22" />
            </InputGroupAddon>
            <InputText type="number" placeholder="SalarioMax" v-model="salarioMax" :disabled="isDisable" />
        </InputGroup>

        <InputGroup>
            <InputGroupAddon class="bg-black text-white">
                <Icon name="material-symbols:person-outline" color="white" size="22" />
            </InputGroupAddon>
            <InputText type="number" placeholder="SalarioMin" v-model="salarioMin" :disabled="isDisable" />
        </InputGroup>

        <InputGroup>
            <InputGroupAddon class="bg-black text-white">
                <Icon name="material-symbols:person-outline" color="white" size="22" />
            </InputGroupAddon>
            <InputText type="text" placeholder="DescFuncion" v-model="descfuncion"
                @input="descfuncion = descfuncion.toLowerCase()" :disabled="isDisable" />
        </InputGroup>

        <InputGroup>
            <InputGroupAddon class="bg-black text-white">
                <Icon name="material-symbols:person-outline" color="white" size="22" />
            </InputGroupAddon>
            <InputText type="text" placeholder="DescCarreras" v-model="descCarreras"
                @input="descCarreras = descCarreras.toLowerCase()" :disabled="isDisable" />
        </InputGroup>

        <InputGroup>
            <InputGroupAddon class="bg-black text-white">
                <Icon name="material-symbols:person-outline" color="white" size="22" />
            </InputGroupAddon>
            <InputText type="number" :min="1" placeholder="nVacantes" v-model="nVacantes" :disabled="isDisable" />
        </InputGroup>

        <div class="card flex flex-col md:flex-row gap-3">
            <InputGroup>
                <InputGroupAddon class="bg-black text-white">
                    <Icon name="majesticons:calendar" color="white" size="22" />
                </InputGroupAddon>
                <FloatLabel>
                    <label for="label-nacimiento">FechaCreacion </label>
                    <Calendar dateFormat="dd/mm/yy" v-model="FechaReque" :disabled="isDisable" />
                </FloatLabel>
            </InputGroup>
        </div>
    </div>
</template>