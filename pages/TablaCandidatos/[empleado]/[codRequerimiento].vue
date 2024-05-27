<script setup>
definePageMeta({
    layout: "landing",
});

const selectedProduct = ref();
const metaKey = ref(true);


import { ref, onMounted } from 'vue';
import { useToast } from 'primevue/usetoast';
import { ProductService } from '@/service/ProductService';

const products = ref();
const expandedRows = ref([]);
const toast = useToast();
let consecHv = ref("");
let usuario = ref("");
let codinstitucion = ref(null);
let idtipoitemperfil = ref(null);
let fechaInicAct = ref(null);
let fechaFinAct = ref(null);
let descActividad = ref(null);
let funcionActividad = ref(null);

onMounted(() => {
    ProductService.getProductsWithOrdersSmall().then((data) => (products.value = data));
});

const onRowExpand = (event) => {
    toast.add({ severity: 'info', summary: 'Product Expanded', detail: event.data.name, life: 3000 });
};
const onRowCollapse = (event) => {
    toast.add({ severity: 'success', summary: 'Product Collapsed', detail: event.data.name, life: 3000 });
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
const getOrderSeverity = (order) => {
    switch (order.status) {
        case 'DELIVERED':
            return 'success';

        case 'CANCELLED':
            return 'danger';

        case 'PENDING':
            return 'warning';

        case 'RETURNED':
            return 'info';

        default:
            return null;
    }
};

</script>

<template>

    <LandingSectionhead>
        <template v-slot:title>Candidatos que cumplen Requerimientos</template>
        <template v-slot:desc>FECHA:</template>
    </LandingSectionhead>

    <div class="flex justify-center align-middle gap-3 mt-5">
            <Button label="Enviar" rounded severity="contrast"
                class="text-white bg-black px-2 py-2"></Button>
            <Button label="Preselecion" rounded severity="contrast" @click="$router.push('/TablaPreseleccion/lau')"
                class="text-white bg-black px-2 py-2"></Button>
        </div>

    <div class="md:grid-cols-1 grid-cols-2 gap-10 mx-auto max-w-screen-lg mt-5">
        <div class="card">
            <DataTable v-model:selection="selectedProduct" v-model:expandedRows="expandedRows" :value="products"
                dataKey="id" @rowExpand="onRowExpand" @rowCollapse="onRowCollapse" tableStyle="min-width: 60rem">
                <template #header>
                    <div class="flex flex-wrap justify-end gap-2">
                        <Button text icon="pi pi-plus" label="Expand All" @click="expandAll" />
                        <Button text icon="pi pi-minus" label="Collapse All" @click="collapseAll" />
                    </div>
                </template>
                <Column selectionMode="multiple" headerStyle="width: 3rem" class="bg-slate-200"></Column>
                <Column field="correo" header="Correo"></Column>
                <Column expander style="width: 5rem" />
                <Column field="nombre" header="Nombre"></Column>
                <Column header="Disciplina">
                    <template #body="slotProps">
                        <img :src="`https://primefaces.org/cdn/primevue/images/product/${slotProps.data.image}`"
                            :alt="slotProps.data.image" class="shadow-lg" width="64" />
                    </template>
                </Column>
                <Column field="tipoItemPerfil" header="tipoItemPerfil">
                    <template #body="slotProps">
                        {{ formatCurrency(slotProps.data.price) }}
                    </template>
                </Column>
                <template #expansion="slotProps">
                    <div class="p-3">
                        <h3>hoja de vida:</h3>
                        <!-- Imagen -->
                        <img src="https://www.w3schools.com/howto/img_avatar.png" alt="Silueta de usuario" style="max-width: 10%; height: auto; margin-bottom: 10px;" />
                        

                        <p><strong>Consechv:</strong> {{ slotProps.data.consecHv }}</p>
                        <p><strong>Usuario:</strong> {{ slotProps.data.usuario }}</p>
                        <p><strong>Código de Institución:</strong> {{ slotProps.data.codinstitucion }}</p>
                        <p><strong>ID Tipo de Item de Perfil:</strong> {{ slotProps.data.idtipoitemperfil }}</p>
                        <p><strong>Fecha de Inicio de Actividad:</strong> {{ slotProps.data.fechaInicAct }}</p>
                        <p><strong>Fecha de Fin de Actividad:</strong> {{ slotProps.data.fechaFinAct }}</p>
                        <p><strong>Descripción de la Actividad:</strong> {{ slotProps.data.descActividad }}</p>
                        <p><strong>Función de la Actividad:</strong> {{ slotProps.data.funcionActividad }}</p>
                        </div>
                </template>
            </DataTable>
            <Toast />
        </div>
    </div>
</template>