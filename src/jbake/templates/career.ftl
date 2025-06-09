<#setting number_format="0">
<#assign sortedList = items?sort_by('bis')?reverse>
<#list sortedList as item>
<#assign vonDate = item.von?date("yyyy-MM-dd")>
<#if item.bis != "heute">
  <#assign bisDate = item.bis?date("yyyy-MM-dd")>
</#if>
<li class="list-group-item d-flex justify-content-between align-items-start">
    <div class="ms-2 me-auto">
        <div class="fw-bold">${item.titel}</div>
        <div class="text-primary">${item.unternehmen}</div>
        <div class="mt-1">
            <span><i class="far fa-calendar"></i> ${vonDate?string("MM/yyyy")} - ${bisDate???then(bisDate?string("MM/yyyy"), 'heute')}</span>
            <span class="ms-5"><i class="fa fa-map-marker"></i> ${item.ort}</span>
        </div>
        <#if (item.beschreibung)??>
        <div class="text-muted mt-1">${item.beschreibung}</div>
        </#if>
        <#if item.aufgaben?? && item.aufgaben?has_content>
        <ul class="mt-1">
            <#list item.aufgaben as aufgabe>
            <li>${aufgabe}</li>
            </#list>
        </ul>
        </#if>
    </div>
</li>
</#list>