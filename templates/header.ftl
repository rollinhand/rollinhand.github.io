<!DOCTYPE html>
<html lang="de">
<head>
  <!-- HTML metadata and includes -->
  <!-- Header information like meta information and script resources -->
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, maximum-scale=1">

  <link rel="icon" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>images/favicon.png" type="image/png">
  <link rel="shortcut icon" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>images/favicon.png" type="image/png">

  <!-- Stylesheets -->
  <link href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>css/styles.css" rel="stylesheet" type="text/css">
  <link href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>css/github.css" rel="stylesheet" type="text/css">
  <!-- Bootstrap icons-->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />

  <!-- Feeds -->
  <link rel="alternate" type="application/atom+xml" title="Atom" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>feed.xml" />

  <!-- Load Highlight.js -->
  <script src="<#if (content.rootpath)??>${content.rootpath}<#else></#if>js/highlight.pack.js"></script>
  <title><#if (content.title)??>${content.title}<#else>Kivio - Blog for DevOps</#if></title>
</head>
<body class="d-flex flex-column h-100">
   