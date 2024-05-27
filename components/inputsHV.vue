<script setup lang="ts">
import { ref, watch, defineEmits } from 'vue'

let consechv = ref("");
let usuario = ref("");
let codinstitucion = ref(null);
let idtipoitemperfil = ref(null);
let fechaInicAct = ref(null);
let fechaFinAct = ref(null);
let descActividad = ref(null);
let funcionActividad = ref(null);


const emit = defineEmits(['update:consechv','update:usuario','update:codinstitucion','update:idtipoitemperfil',
'update:fechaInicAct', 'update:fechaFinAct', 'update:descActividad', 'update:funcionActividad',
 ])


let isDisable = ref(true)
</script>


