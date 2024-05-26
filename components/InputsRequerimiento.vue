<script setup lang="ts">
import { ref, watch, defineEmits } from 'vue'

let cod = ref(null)
let salarioMax = ref("")
let salarioMin = ref("")
let nVacantes = ref("")
let descfuncion = ref("")
let descCarreras = ref("")
let FechaReque = ref(null)

const emit = defineEmits(['update:cod','update:salarioMax','update:salarioMin','update:nVacantes','update:descfuncion','update:descCarreras','update:FechaReque'])

watch(cod, (newVal) => {
  emit('update:cod', newVal)
})

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

let isDisable = ref(true)
</script>

<template>
    <div class="grid md:grid-cols-2 gap-10 mx-auto max-w-4xl">
        <!-- input General -->
        <InputGroup>
            <InputGroupAddon class="bg-black text-white">
                <Icon name="material-symbols:person-outline" color="white" size="22" />
            </InputGroupAddon>
            <InputText type="number" :min="0" placeholder="ConsecReque" v-model="cod" :disabled="isDisable"/>
        </InputGroup>

        <InputGroup>
            <InputGroupAddon class="bg-black text-white">
                <Icon name="material-symbols:person-outline" color="white" size="22" />
            </InputGroupAddon>
            <InputText type="number" placeholder="SalarioMax" v-model="salarioMax" />
        </InputGroup>

        <InputGroup>
            <InputGroupAddon class="bg-black text-white">
                <Icon name="material-symbols:person-outline" color="white" size="22" />
            </InputGroupAddon>
            <InputText type="number" placeholder="SalarioMin" v-model="salarioMin" />
        </InputGroup>

        <InputGroup>
            <InputGroupAddon class="bg-black text-white">
                <Icon name="material-symbols:person-outline" color="white" size="22" />
            </InputGroupAddon>
            <InputText type="text" placeholder="DescFuncion" v-model="descfuncion"
                @input="descfuncion = descfuncion.toLowerCase()" />
        </InputGroup>

        <InputGroup>
            <InputGroupAddon class="bg-black text-white">
                <Icon name="material-symbols:person-outline" color="white" size="22" />
            </InputGroupAddon>
            <InputText type="text" placeholder="DescCarreras" v-model="descCarreras"
                @input="descCarreras = descCarreras.toLowerCase()" />
        </InputGroup>

        <InputGroup>
            <InputGroupAddon class="bg-black text-white">
                <Icon name="material-symbols:person-outline" color="white" size="22" />
            </InputGroupAddon>
            <InputText type="number" :min="1" placeholder="nVacantes" v-model="nVacantes" />
        </InputGroup>

        <div class="card flex flex-col md:flex-row gap-3">
            <InputGroup>
                <InputGroupAddon class="bg-black text-white">
                    <Icon name="majesticons:calendar" color="white" size="22" />
                </InputGroupAddon>
                <FloatLabel>
                    <label for="label-nacimiento">FechaCreacion </label>
                    <Calendar dateFormat="dd/mm/yy" v-model="FechaReque" />
                </FloatLabel>
            </InputGroup>
        </div>
    </div>
</template>