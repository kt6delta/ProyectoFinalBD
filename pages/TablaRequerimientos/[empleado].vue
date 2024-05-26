<script setup>
definePageMeta({
    layout: "landing",
});

import { ref, onMounted } from 'vue';
import { useToast } from 'primevue/usetoast';
import { ProductService } from '@/service/ProductService';

const currentDate = new Date().toLocaleDateString();
const products = ref();
const expandedRows = ref([]);
const toast = useToast();

onMounted(() => {
    ProductService.getProductsWithOrdersSmall().then((data) => (products.value = data));
});

const onRowExpand = (event) => {
    toast.add({ severity: 'info', summary: 'Requerimiento Expandido', detail: event.data.name, life: 3000 });
};
const onRowCollapse = (event) => {
    toast.add({ severity: 'success', summary: 'Requerimiento Contraido', detail: event.data.name, life: 3000 });
};
const expandAll = () => {
    expandedRows.value = products.value.reduce((acc, p) => (acc[p.id] = true) && acc, {});
};
const collapseAll = () => {
    expandedRows.value = null;
};
const formatCurrency = (value) => {
    return value.toLocaleString('en-US', { style: 'currency', currency: 'USD' });
};
const getSeverity = (product) => {
    switch (product.inventoryStatus) {
        case 'INSTOCK':
            return 'success';

        case 'LOWSTOCK':
            return 'warning';

        case 'OUTOFSTOCK':
            return 'danger';

        default:
            return null;
    }
};

let CodRequerimiento = 0;
function Candidatos() {
    const router = useRouter();
    const route = useRoute();
    router.push(`/TablaCandidatos/${route.params.empleado}/${CodRequerimiento}`);
}

</script>

<template>
    <LandingSectionhead>
        <template v-slot:title>Requerimientos Pendientes</template>
        <template v-slot:desc>FECHA: {{ currentDate }}</template>
    </LandingSectionhead>

    <div class="md:grid-cols-1 grid-cols-2 gap-10 mx-auto max-w-screen-lg mt-12">
        <div class="card">
            <DataTable v-model:expandedRows="expandedRows" :value="products" dataKey="id" @rowExpand="onRowExpand"
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
                        123
                    </template>
                </Column>
                <Column header="Perfil">
                    <template #body="slotProps">
                        <img :src="`https://primefaces.org/cdn/primevue/images/product/${slotProps.data.image}`"
                            :alt="slotProps.data.image" class="shadow-lg" width="64" />
                    </template>
                </Column>
                <Column field="diciplina" header="Diciplina">
                    <template #body="slotProps">
                        {{ formatCurrency(slotProps.data.price) }}
                    </template>
                </Column>
                <Column field="faseFaltante" header="FasesFaltantes">
                    <template #body="slotProps">
                        <Rating :modelValue="slotProps.data.rating" readonly :cancel="false" />
                    </template>
                </Column>
                <Column field="faseActual" header="FaseActual">
                    <template #body="slotProps">
                        <Tag :value="slotProps.data.inventoryStatus" :severity="getSeverity(slotProps.data)" />
                    </template>
                </Column>
                <template #expansion="slotProps">
                    <div class="p-3">
                        <h>Componente para editar TABLA Requerimiento
                            CONSECREQUE
                            FECHAREQUE
                            SALARIOMAX
                            SALARIOMIN
                            DESCFUNCION
                            DESCCARRERAS
                            NVACANTES
                        </h>
                        <Icon name="bxs:pencil" size="25" />
                    </div>
                    <div class="p-3">
                        <h>Componente para editar TABLA procesorequerimiento
                            IDPERFIL ->perfil
                            IDFASE ->fase
                            CONSECREQUE
                            CONSEPROCESO
                            FECHAINICIO
                            FECHAFIN
                            CONVOCATORIA
                            INVITACION (correo)
                        </h>
                        <Icon name="bxs:pencil" size="25" />
                    </div>
                    <div class="p-3">
                        <Button label="Candidatos" severity="success" class="text-white bg-primary p-1"
                            @click="Candidatos"></Button>
                    </div>
                </template>
            </DataTable>
            <Toast />
        </div>
    </div>
</template>