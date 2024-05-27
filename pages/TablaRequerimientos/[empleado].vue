<script setup>
definePageMeta({
    layout: "landing",
});
import InputsRequerimiento from '@/components/InputsRequerimiento.vue';
let disable = ref(true)
function EditRequerimiento() {
    disable.value = !disable.value
}
const router = useRouter();
const route = useRoute();
let CodRequerimiento = 0;
function Candidatos() {
    router.push(`/TablaCandidatos/${route.params.empleado}/${CodRequerimiento}`);
}
const currentDate = new Date().toLocaleDateString();

import { ref } from 'vue';
import { useToast } from 'primevue/usetoast';

const requerimiento = ref();

onMounted(async () => {
    requerimiento.value = await $fetch(`/requerimientos/${route.params.empleado}`);
    console.log(requerimiento.value);
    //adiciona diciplina y perfil
});

const expandedRows = ref([]);
const toast = useToast();

const onRowExpand = (event) => {
    toast.add({ severity: 'info', summary: 'Requerimiento Expandido', detail: event.data.CONSECREQUE, life: 3000 });
};
const onRowCollapse = (event) => {
    toast.add({ severity: 'success', summary: 'Requerimiento Contraido', detail: event.data.CONSECREQUE, life: 3000 });
};
const expandAll = () => {
    expandedRows.value = requerimiento.value.reduce((acc, p) => (acc[p.CONSECREQUE] = true) && acc, {});
};
const collapseAll = () => {
    expandedRows.value = null;
};

const getSeverity = (fase) => {
    switch (fase) {
        case 'Registrar Requerimiento':
            return 'Primary';

        case 'Asignar Perfil':
            return 'secondary';

        case 'Publicar Convocatoria':
            return 'success';

        case 'Mandar Invitación':
            return 'info';

        case 'Preselección':
            return 'warning';

        case 'Realizar Prueba':
            return 'danger';

        case 'Entrevista':
            return 'contrast';

        default:
            return null;
    }
};

</script>

<template>
    <LandingSectionhead>
        <template v-slot:title>Requerimientos Pendientes</template>
        <template v-slot:desc>FECHA: {{ currentDate }}</template>
    </LandingSectionhead>

    <div class="md:grid-cols-1 grid-cols-2 gap-10 mx-auto max-w-screen-lg mt-12">
        <div class="card">

            <DataTable v-model:expandedRows="expandedRows" :value="requerimiento" dataKey="id" @rowExpand="onRowExpand"
                @rowCollapse="onRowCollapse" tableStyle="min-width: 60rem">

                <template #header>
                    <div class="flex flex-wrap justify-end gap-2">
                        <Button text icon="pi pi-plus" label="Expand All" @click="expandAll" />
                        <Button text icon="pi pi-minus" label="Collapse All" @click="collapseAll" />
                    </div>
                </template>
                <Column expander style="width: 5rem" />
                <Column field="Consec" header="Consec">
                    <template #body="slotProps">
                       <p>{{ slotProps.data.CONSECREQUE }}</p>
                    </template>
                </Column>
                <Column header="Perfil">
                    <template #body="slotProps">
                        <p>{{ slotProps.data.perfil.DESCPERFIL }}</p>
                    </template>
                </Column>
                <Column field="diciplina" header="Diciplina">
                    <template #body="slotProps">
                        {{ slotProps.data.disciplina.DESCDISCIPLINA }}
                    </template>
                </Column>
                <Column field="faseFaltante" header="FasesFaltantes">
                    <template #body="slotProps">
                        <Rating :modelValue="slotProps.data.fase.DESCFASE" readonly :cancel="false" />
                    </template>
                </Column>
                <Column field="faseActual" header="FaseActual">
                    <template #body="slotProps">
                        <Tag :value="slotProps.data.fase.DESCFASE" :severity="getSeverity(slotProps.data.fase.DESCFASE)" />
                    </template>
                </Column>
                <template #expansion="slotProps">
                    <InputsRequerimiento :PropisDisable="disable" :PropCod=slotProps.data.CONSECREQUE :PropSalarioMax="slotProps.data.SALARIOMAX" :PropSalarioMin="slotProps.data.SALARIOMIN"
                        :PropNVacantes="slotProps.data.NVACANTES" :PropDescfuncion="slotProps.data.DESCFUNCION" :PropDescCarreras="slotProps.data.DESCCARRERAS" :PropFechaReque="slotProps.data.FECHAREQUE" />
                    <div class="flex justify-end mr-5">
                        <Button aria-label="Submit" @click="EditRequerimiento">
                            <Icon name="bxs:pencil" size="25" />
                        </Button>
                    </div>
                    <div class="p-3">
                        <h1>Componente para editar TABLA procesorequerimiento
                            IDPERFIL ->perfil
                            IDFASE ->fase
                            CONSECREQUE
                            CONSEPROCESO
                            FECHAINICIO
                            FECHAFIN
                            CONVOCATORIA
                            INVITACION (correo)
                        </h1>
                        <Icon name="bxs:pencil" size="25" />
                    </div>
                    <div class="p-3">
                        <Button label="Candidatos" severity="success" class="text-white bg-primary p-1"
                            @click="Candidatos" />
                    </div>
                </template>
            </DataTable>
            <Toast />
        </div>
    </div>
</template>