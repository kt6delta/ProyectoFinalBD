<script setup>
definePageMeta({
    layout: "landing",
});
import InputsRequerimiento from '@/components/InputsRequerimiento.vue';
import inputsProcesoRequerimiento from '@/components/inputsProcesoRequerimiento.vue';
import { ref } from 'vue';

let disable = ref(true)
function EditRequerimiento() {
    disable.value = !disable.value
}
let disable2 = ref(true)
function EditProcRequerimiento() {
    disable2.value = !disable2.value
}

let RequerimientoC = ref(null)
function putRequerimiento(codReq) {
    EditRequerimiento()
    RequerimientoC.value.put(codReq);
}

let RequeProcesC = ref(null)
function PutProcRequerimiento(codReq) {
    EditProcRequerimiento()
    RequeProcesC.value.put(codReq);
}

const router = useRouter();
const route = useRoute();
let CodRequerimiento = ref();
function Candidatos() {
    router.push(`/TablaCandidatos/${route.params.empleado}/${CodRequerimiento.value}`);
}
const currentDate = new Date().toLocaleDateString();

import { useToast } from 'primevue/usetoast';

const requerimiento = ref([]);

onMounted(async () => {
    let req = await $fetch(`/requerimientos/${route.params.empleado}`);
    let proceso = await $fetch(`/requerimientos/proceso/${route.params.empleado}`);
    const combinedArray = req.map((item, index) => {
        let copy = { ...item, ...proceso[index] }
        return copy;
    });
    requerimiento.value = combinedArray;
});

const expandedRows = ref([]);
const toast = useToast();

const onRowExpand = (event) => {
    CodRequerimiento.value = event.data.CONSECREQUE;
    toast.add({ severity: 'info', summary: 'Requerimiento Expandido', detail: event.data.CONSECREQUE, life: 3000 });
};
const onRowCollapse = (event) => {
    toast.add({ severity: 'success', summary: 'Requerimiento Contraido', detail: event.data.CONSECREQUE, life: 3000 });
};
const expandAll = () => {
    expandedRows.value = requerimiento.value.reduce((acc, p) => (acc[p] = true) && acc, {});
};
const collapseAll = () => {
    expandedRows.value = null;
};

const getSeverity = (fase) => {
    switch (fase) {
        case '1':
            return 'Primary';

        case '2':
            return 'secondary';

        case '3':
            return 'success';

        case '4':
            return 'info';

        case '5':
            return 'warning';

        case '6':
            return 'danger';

        case '7':
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
            <DataTable v-model:expandedRows="expandedRows" :value="requerimiento" dataKey="CONSECREQUE"
                @rowExpand="onRowExpand" @rowCollapse="onRowCollapse" tableStyle="min-width: 60rem">

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
                        <p>{{ slotProps.data.PERFIL.DESCPERFIL }}</p>
                    </template>
                </Column>
                <Column field="diciplina" header="Diciplina">
                    <template #body="slotProps">
                        {{ slotProps.data.DISCIPLINA.DESCDISCIPLINA }}
                    </template>
                </Column>
                <Column field="faseFaltante" header="FasesFaltantes">
                    <template #body="slotProps">
                        <Rating :modelValue="Number(slotProps.data.FASE.IDFASE)" readonly :cancel="false" :stars="8" />
                    </template>
                </Column>
                <Column field="faseActual" header="FaseActual">
                    <template #body="slotProps">
                        <Tag :value="slotProps.data.FASE.DESCFASE"
                            :severity="getSeverity(slotProps.data.FASE.IDFASE)" />
                    </template>
                </Column>
                <template #expansion="slotProps">
                    <InputsRequerimiento :PropisDisable="disable" :PropCod=slotProps.data.CONSECREQUE
                        :PropSalarioMax="slotProps.data.SALARIOMAX" :PropSalarioMin="slotProps.data.SALARIOMIN"
                        :PropNVacantes="slotProps.data.NVACANTES" :PropDescfuncion="slotProps.data.DESCFUNCION"
                        :PropDescCarreras="slotProps.data.DESCCARRERAS" :PropFechaReque="slotProps.data.FECHAREQUE"
                        ref="RequerimientoC" />
                    <div class="flex justify-end mr-5">
                        <Button v-if="disable" aria-label="Submit" @click="EditRequerimiento">
                            <Icon name="bxs:pencil" size="25" />
                        </Button>
                        <Button v-if="!disable" aria-label="Submit" @click="putRequerimiento(slotProps.data.CONSECREQUE)">
                            <Icon name="ic:baseline-check" size="25" />
                        </Button>
                        <Button v-if="!disable" aria-label="Submit" @click="EditRequerimiento" class="m-5">
                            <Icon name="streamline:delete-1-solid" size="16" />
                        </Button>
                    </div>
                    <inputsProcesoRequerimiento :PropisDisable2="disable2" :PropselectedPerfil="slotProps.data.PERFIL"
                        :PropselectedFase="slotProps.data.FASE" :Propconvocatoria="slotProps.data.CONVOCATORIA"
                        :Propinvitacion="slotProps.data.INVITACION" :PropfechaInicio="slotProps.data.FECHAINICIO"
                        :PropfechaFin="slotProps.data.FECHAFIN" ref="RequeProcesC" />
                    <div class="flex justify-end mr-5">
                        <Button v-if="disable2" aria-label="Submit" @click="EditProcRequerimiento">
                            <Icon name="bxs:pencil" size="25" />
                        </Button>
                        <Button v-if="!disable2" aria-label="Submit" @click="PutProcRequerimiento(slotProps.data.CONSECREQUE)">
                            <Icon name="ic:baseline-check" size="25" />
                        </Button>
                        <Button v-if="!disable2" aria-label="Submit" @click="EditProcRequerimiento" class="m-5">
                            <Icon name="streamline:delete-1-solid" size="16" />
                        </Button>
                    </div>
                    <div class="p-3 ml-10">
                        <Button label="Candidatos" severity="success" class="text-white bg-primary p-1"
                            @click="Candidatos" />
                    </div>
                </template>
            </DataTable>
            <Toast />
        </div>
    </div>
</template>