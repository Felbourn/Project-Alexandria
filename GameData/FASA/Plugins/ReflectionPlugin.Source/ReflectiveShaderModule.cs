



<!DOCTYPE html>
<html lang="en" class="   ">
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# object: http://ogp.me/ns/object# article: http://ogp.me/ns/article# profile: http://ogp.me/ns/profile#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Language" content="en">
    
    
    <title>Reflection-Plugin-Continued/ReflectiveShaderModule.cs at master · Starwaster/Reflection-Plugin-Continued · GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub">
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub">
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-114.png">
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114.png">
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-144.png">
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144.png">
    <meta property="fb:app_id" content="1401488693436528">

      <meta content="@github" name="twitter:site" /><meta content="summary" name="twitter:card" /><meta content="Starwaster/Reflection-Plugin-Continued" name="twitter:title" /><meta content="Reflection-Plugin-Continued - This is an updated version of the Reflection Plugin created by Razchek with some additional features and fixes that provide more control over reflective materials and non" name="twitter:description" /><meta content="https://avatars1.githubusercontent.com/u/5440121?v=2&amp;s=400" name="twitter:image:src" />
<meta content="GitHub" property="og:site_name" /><meta content="object" property="og:type" /><meta content="https://avatars1.githubusercontent.com/u/5440121?v=2&amp;s=400" property="og:image" /><meta content="Starwaster/Reflection-Plugin-Continued" property="og:title" /><meta content="https://github.com/Starwaster/Reflection-Plugin-Continued" property="og:url" /><meta content="Reflection-Plugin-Continued - This is an updated version of the Reflection Plugin created by Razchek with some additional features and fixes that provide more control over reflective materials and non-realtime updating for performance increases." property="og:description" />

    <link rel="assets" href="https://assets-cdn.github.com/">
    <link rel="conduit-xhr" href="https://ghconduit.com:25035">
    

    <meta name="msapplication-TileImage" content="/windows-tile.png">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="selected-link" value="repo_source" data-pjax-transient>
      <meta name="google-analytics" content="UA-3769691-2">

    <meta content="collector.githubapp.com" name="octolytics-host" /><meta content="collector-cdn.github.com" name="octolytics-script-host" /><meta content="github" name="octolytics-app-id" /><meta content="46755172:6A4A:E725530:53FB7D0E" name="octolytics-dimension-request_id" />
    

    
    
    <link rel="icon" type="image/x-icon" href="https://assets-cdn.github.com/favicon.ico">


    <meta content="authenticity_token" name="csrf-param" />
<meta content="V44jKmCxUuZ8j1qOiQzq96yByyO4jRomhpQq747GkQH3BZwIAwZ3nhbuOZp2Q9wHSPXN1GHTUfm1c1yUhZDDEg==" name="csrf-token" />

    <link href="https://assets-cdn.github.com/assets/github-c42e52ca7947fa1d1ee79edddeebf592213d7224.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://assets-cdn.github.com/assets/github2-690d1864b28aa6d2e824fea6953c01baa82cc813.css" media="all" rel="stylesheet" type="text/css" />
    


    <meta http-equiv="x-pjax-version" content="00271110ffe895a62ef4dd95a118c542">

      
  <meta name="description" content="Reflection-Plugin-Continued - This is an updated version of the Reflection Plugin created by Razchek with some additional features and fixes that provide more control over reflective materials and non-realtime updating for performance increases.">
  <meta name="go-import" content="github.com/Starwaster/Reflection-Plugin-Continued git https://github.com/Starwaster/Reflection-Plugin-Continued.git">

  <meta content="5440121" name="octolytics-dimension-user_id" /><meta content="Starwaster" name="octolytics-dimension-user_login" /><meta content="21115859" name="octolytics-dimension-repository_id" /><meta content="Starwaster/Reflection-Plugin-Continued" name="octolytics-dimension-repository_nwo" /><meta content="true" name="octolytics-dimension-repository_public" /><meta content="false" name="octolytics-dimension-repository_is_fork" /><meta content="21115859" name="octolytics-dimension-repository_network_root_id" /><meta content="Starwaster/Reflection-Plugin-Continued" name="octolytics-dimension-repository_network_root_nwo" />
  <link href="https://github.com/Starwaster/Reflection-Plugin-Continued/commits/master.atom" rel="alternate" title="Recent Commits to Reflection-Plugin-Continued:master" type="application/atom+xml">

  </head>


  <body class="logged_out  env-production windows vis-public page-blob">
    <a href="#start-of-content" tabindex="1" class="accessibility-aid js-skip-to-content">Skip to content</a>
    <div class="wrapper">
      
      
      
      


      
      <div class="header header-logged-out">
  <div class="container clearfix">

    <a class="header-logo-wordmark" href="https://github.com/">
      <span class="mega-octicon octicon-logo-github"></span>
    </a>

    <div class="header-actions">
        <a class="button primary" href="/join">Sign up</a>
      <a class="button signin" href="/login?return_to=%2FStarwaster%2FReflection-Plugin-Continued%2Fblob%2Fmaster%2FReflectiveShaderModule.cs">Sign in</a>
    </div>

    <div class="site-search repo-scope js-site-search">
      <form accept-charset="UTF-8" action="/Starwaster/Reflection-Plugin-Continued/search" class="js-site-search-form" data-global-search-url="/search" data-repo-search-url="/Starwaster/Reflection-Plugin-Continued/search" method="get"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
  <input type="text"
    class="js-site-search-field is-clearable"
    data-hotkey="s"
    name="q"
    placeholder="Search"
    data-global-scope-placeholder="Search GitHub"
    data-repo-scope-placeholder="Search"
    tabindex="1"
    autocapitalize="off">
  <div class="scope-badge">This repository</div>
</form>
    </div>

      <ul class="header-nav left">
          <li class="header-nav-item">
            <a class="header-nav-link" href="/explore">Explore</a>
          </li>
          <li class="header-nav-item">
            <a class="header-nav-link" href="/features">Features</a>
          </li>
          <li class="header-nav-item">
            <a class="header-nav-link" href="https://enterprise.github.com/">Enterprise</a>
          </li>
          <li class="header-nav-item">
            <a class="header-nav-link" href="/blog">Blog</a>
          </li>
      </ul>

  </div>
</div>



      <div id="start-of-content" class="accessibility-aid"></div>
          <div class="site" itemscope itemtype="http://schema.org/WebPage">
    <div id="js-flash-container">
      
    </div>
    <div class="pagehead repohead instapaper_ignore readability-menu">
      <div class="container">
        
<ul class="pagehead-actions">


  <li>
      <a href="/login?return_to=%2FStarwaster%2FReflection-Plugin-Continued"
    class="minibutton with-count star-button tooltipped tooltipped-n"
    aria-label="You must be signed in to star a repository" rel="nofollow">
    <span class="octicon octicon-star"></span>
    Star
  </a>

    <a class="social-count js-social-count" href="/Starwaster/Reflection-Plugin-Continued/stargazers">
      0
    </a>

  </li>

    <li>
      <a href="/login?return_to=%2FStarwaster%2FReflection-Plugin-Continued"
        class="minibutton with-count js-toggler-target fork-button tooltipped tooltipped-n"
        aria-label="You must be signed in to fork a repository" rel="nofollow">
        <span class="octicon octicon-repo-forked"></span>
        Fork
      </a>
      <a href="/Starwaster/Reflection-Plugin-Continued/network" class="social-count">
        2
      </a>
    </li>
</ul>

        <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
          <span class="mega-octicon octicon-repo"></span>
          <span class="author"><a href="/Starwaster" class="url fn" itemprop="url" rel="author"><span itemprop="title">Starwaster</span></a></span><!--
       --><span class="path-divider">/</span><!--
       --><strong><a href="/Starwaster/Reflection-Plugin-Continued" class="js-current-repository js-repo-home-link">Reflection-Plugin-Continued</a></strong>

          <span class="page-context-loader">
            <img alt="" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
          </span>

        </h1>
      </div><!-- /.container -->
    </div><!-- /.repohead -->

    <div class="container">
      <div class="repository-with-sidebar repo-container new-discussion-timeline  ">
        <div class="repository-sidebar clearfix">
            
<div class="sunken-menu vertical-right repo-nav js-repo-nav js-repository-container-pjax js-octicon-loaders" data-issue-count-url="/Starwaster/Reflection-Plugin-Continued/issues/counts">
  <div class="sunken-menu-contents">
    <ul class="sunken-menu-group">
      <li class="tooltipped tooltipped-w" aria-label="Code">
        <a href="/Starwaster/Reflection-Plugin-Continued" aria-label="Code" class="selected js-selected-navigation-item sunken-menu-item" data-hotkey="g c" data-pjax="true" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches /Starwaster/Reflection-Plugin-Continued">
          <span class="octicon octicon-code"></span> <span class="full-word">Code</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

        <li class="tooltipped tooltipped-w" aria-label="Issues">
          <a href="/Starwaster/Reflection-Plugin-Continued/issues" aria-label="Issues" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g i" data-selected-links="repo_issues repo_labels repo_milestones /Starwaster/Reflection-Plugin-Continued/issues">
            <span class="octicon octicon-issue-opened"></span> <span class="full-word">Issues</span>
            <span class="js-issue-replace-counter"></span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>

      <li class="tooltipped tooltipped-w" aria-label="Pull Requests">
        <a href="/Starwaster/Reflection-Plugin-Continued/pulls" aria-label="Pull Requests" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g p" data-selected-links="repo_pulls /Starwaster/Reflection-Plugin-Continued/pulls">
            <span class="octicon octicon-git-pull-request"></span> <span class="full-word">Pull Requests</span>
            <span class="js-pull-replace-counter"></span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>


    </ul>
    <div class="sunken-menu-separator"></div>
    <ul class="sunken-menu-group">

      <li class="tooltipped tooltipped-w" aria-label="Pulse">
        <a href="/Starwaster/Reflection-Plugin-Continued/pulse/weekly" aria-label="Pulse" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="pulse /Starwaster/Reflection-Plugin-Continued/pulse/weekly">
          <span class="octicon octicon-pulse"></span> <span class="full-word">Pulse</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped tooltipped-w" aria-label="Graphs">
        <a href="/Starwaster/Reflection-Plugin-Continued/graphs" aria-label="Graphs" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="repo_graphs repo_contributors /Starwaster/Reflection-Plugin-Continued/graphs">
          <span class="octicon octicon-graph"></span> <span class="full-word">Graphs</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>
    </ul>


  </div>
</div>

              <div class="only-with-full-nav">
                
  
<div class="clone-url open"
  data-protocol-type="http"
  data-url="/users/set_protocol?protocol_selector=http&amp;protocol_type=clone">
  <h3><span class="text-emphasized">HTTPS</span> clone URL</h3>
  <div class="input-group">
    <input type="text" class="input-mini input-monospace js-url-field"
           value="https://github.com/Starwaster/Reflection-Plugin-Continued.git" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/Starwaster/Reflection-Plugin-Continued.git" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  
<div class="clone-url "
  data-protocol-type="subversion"
  data-url="/users/set_protocol?protocol_selector=subversion&amp;protocol_type=clone">
  <h3><span class="text-emphasized">Subversion</span> checkout URL</h3>
  <div class="input-group">
    <input type="text" class="input-mini input-monospace js-url-field"
           value="https://github.com/Starwaster/Reflection-Plugin-Continued" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/Starwaster/Reflection-Plugin-Continued" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>


<p class="clone-options">You can clone with
      <a href="#" class="js-clone-selector" data-protocol="http">HTTPS</a>
      or <a href="#" class="js-clone-selector" data-protocol="subversion">Subversion</a>.
  <a href="https://help.github.com/articles/which-remote-url-should-i-use" class="help tooltipped tooltipped-n" aria-label="Get help on which URL is right for you.">
    <span class="octicon octicon-question"></span>
  </a>
</p>


  <a href="http://windows.github.com" class="minibutton sidebar-button" title="Save Starwaster/Reflection-Plugin-Continued to your computer and use it in GitHub Desktop." aria-label="Save Starwaster/Reflection-Plugin-Continued to your computer and use it in GitHub Desktop.">
    <span class="octicon octicon-device-desktop"></span>
    Clone in Desktop
  </a>

                <a href="/Starwaster/Reflection-Plugin-Continued/archive/master.zip"
                   class="minibutton sidebar-button"
                   aria-label="Download Starwaster/Reflection-Plugin-Continued as a zip file"
                   title="Download Starwaster/Reflection-Plugin-Continued as a zip file"
                   rel="nofollow">
                  <span class="octicon octicon-cloud-download"></span>
                  Download ZIP
                </a>
              </div>
        </div><!-- /.repository-sidebar -->

        <div id="js-repo-pjax-container" class="repository-content context-loader-container" data-pjax-container>
          

<a href="/Starwaster/Reflection-Plugin-Continued/blob/2a1314d2f555d405184121e022b8e8668bf1928c/ReflectiveShaderModule.cs" class="hidden js-permalink-shortcut" data-hotkey="y">Permalink</a>

<!-- blob contrib key: blob_contributors:v21:c71e374bde1fd0adaf262a3d81a8c0d9 -->

<div class="file-navigation">
  
<div class="select-menu js-menu-container js-select-menu left">
  <span class="minibutton select-menu-button js-menu-target css-truncate" data-hotkey="w"
    data-master-branch="master"
    data-ref="master"
    title="master"
    role="button" aria-label="Switch branches or tags" tabindex="0" aria-haspopup="true">
    <span class="octicon octicon-git-branch"></span>
    <i>branch:</i>
    <span class="js-select-button css-truncate-target">master</span>
  </span>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax aria-hidden="true">

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <span class="select-menu-title">Switch branches/tags</span>
        <span class="octicon octicon-x js-menu-close" role="button" aria-label="Close"></span>
      </div> <!-- /.select-menu-header -->

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" aria-label="Filter branches/tags" id="context-commitish-filter-field" class="js-filterable-field js-navigation-enable" placeholder="Filter branches/tags">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" class="js-select-menu-tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" class="js-select-menu-tab">Tags</a>
            </li>
          </ul>
        </div><!-- /.select-menu-tabs -->
      </div><!-- /.select-menu-filters -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/Starwaster/Reflection-Plugin-Continued/blob/Dev/ReflectiveShaderModule.cs"
                 data-name="Dev"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="Dev">Dev</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item selected">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/Starwaster/Reflection-Plugin-Continued/blob/master/ReflectiveShaderModule.cs"
                 data-name="master"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="master">master</a>
            </div> <!-- /.select-menu-item -->
        </div>

          <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

    </div> <!-- /.select-menu-modal -->
  </div> <!-- /.select-menu-modal-holder -->
</div> <!-- /.select-menu -->

  <div class="button-group right">
    <a href="/Starwaster/Reflection-Plugin-Continued/find/master"
          class="js-show-file-finder minibutton empty-icon tooltipped tooltipped-s"
          data-pjax
          data-hotkey="t"
          aria-label="Quickly jump between files">
      <span class="octicon octicon-list-unordered"></span>
    </a>
    <button class="js-zeroclipboard minibutton zeroclipboard-button"
          data-clipboard-text="ReflectiveShaderModule.cs"
          aria-label="Copy to clipboard"
          data-copied-hint="Copied!">
      <span class="octicon octicon-clippy"></span>
    </button>
  </div>

  <div class="breadcrumb">
    <span class='repo-root js-repo-root'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/Starwaster/Reflection-Plugin-Continued" class="" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">Reflection-Plugin-Continued</span></a></span></span><span class="separator"> / </span><strong class="final-path">ReflectiveShaderModule.cs</strong>
  </div>
</div>


  <div class="commit commit-loader file-history-tease js-deferred-content" data-url="/Starwaster/Reflection-Plugin-Continued/contributors/master/ReflectiveShaderModule.cs">
    Fetching contributors…

    <div class="participation">
      <p class="loader-loading"><img alt="" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32-EAF2F5.gif" width="16" /></p>
      <p class="loader-error">Cannot retrieve contributors at this time</p>
    </div>
  </div>

<div class="file-box">
  <div class="file">
    <div class="meta clearfix">
      <div class="info file-name">
          <span>243 lines (228 sloc)</span>
          <span class="meta-divider"></span>
        <span>12.032 kb</span>
      </div>
      <div class="actions">
        <div class="button-group">
          <a href="/Starwaster/Reflection-Plugin-Continued/raw/master/ReflectiveShaderModule.cs" class="minibutton " id="raw-url">Raw</a>
            <a href="/Starwaster/Reflection-Plugin-Continued/blame/master/ReflectiveShaderModule.cs" class="minibutton js-update-url-with-hash">Blame</a>
          <a href="/Starwaster/Reflection-Plugin-Continued/commits/master/ReflectiveShaderModule.cs" class="minibutton " rel="nofollow">History</a>
        </div><!-- /.button-group -->

          <a class="octicon-button tooltipped tooltipped-nw"
             href="http://windows.github.com" aria-label="Open this file in GitHub for Windows">
              <span class="octicon octicon-device-desktop"></span>
          </a>

            <a class="octicon-button disabled tooltipped tooltipped-w" href="#"
               aria-label="You must be signed in to make or propose changes"><span class="octicon octicon-pencil"></span></a>

          <a class="octicon-button danger disabled tooltipped tooltipped-w" href="#"
             aria-label="You must be signed in to make or propose changes">
          <span class="octicon octicon-trashcan"></span>
        </a>
      </div><!-- /.actions -->
    </div>
      
  <div class="blob-wrapper data type-c">
      <table class="highlight tab-size-8 js-file-line-container">
      <tr>
        <td id="L1" class="blob-line-num js-line-number" data-line-number="1"></td>
        <td id="LC1" class="blob-line-code js-file-line"><span class="k">using</span> <span class="nn">System</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L2" class="blob-line-num js-line-number" data-line-number="2"></td>
        <td id="LC2" class="blob-line-code js-file-line"><span class="k">using</span> <span class="nn">System.Collections.Generic</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L3" class="blob-line-num js-line-number" data-line-number="3"></td>
        <td id="LC3" class="blob-line-code js-file-line"><span class="k">using</span> <span class="nn">System.Linq</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L4" class="blob-line-num js-line-number" data-line-number="4"></td>
        <td id="LC4" class="blob-line-code js-file-line"><span class="k">using</span> <span class="nn">UnityEngine</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L5" class="blob-line-num js-line-number" data-line-number="5"></td>
        <td id="LC5" class="blob-line-code js-file-line"><span class="k">using</span> <span class="nn">System.IO</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L6" class="blob-line-num js-line-number" data-line-number="6"></td>
        <td id="LC6" class="blob-line-code js-file-line"><span class="k">using</span> <span class="nn">System.Text</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L7" class="blob-line-num js-line-number" data-line-number="7"></td>
        <td id="LC7" class="blob-line-code js-file-line"><span class="k">using</span> <span class="nn">System.Reflection</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L8" class="blob-line-num js-line-number" data-line-number="8"></td>
        <td id="LC8" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L9" class="blob-line-num js-line-number" data-line-number="9"></td>
        <td id="LC9" class="blob-line-code js-file-line"><span class="k">namespace</span> <span class="nn">ReflectionPlugin</span></td>
      </tr>
      <tr>
        <td id="L10" class="blob-line-num js-line-number" data-line-number="10"></td>
        <td id="LC10" class="blob-line-code js-file-line"><span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L11" class="blob-line-num js-line-number" data-line-number="11"></td>
        <td id="LC11" class="blob-line-code js-file-line">    <span class="k">public</span> <span class="k">class</span> <span class="nc">ReflectiveShaderModule</span> <span class="p">:</span> <span class="n">PartModule</span></td>
      </tr>
      <tr>
        <td id="L12" class="blob-line-num js-line-number" data-line-number="12"></td>
        <td id="LC12" class="blob-line-code js-file-line">    <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L13" class="blob-line-num js-line-number" data-line-number="13"></td>
        <td id="LC13" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L14" class="blob-line-num js-line-number" data-line-number="14"></td>
        <td id="LC14" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">int</span> <span class="n">CubeMapSize</span> <span class="p">=</span> <span class="m">128</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L15" class="blob-line-num js-line-number" data-line-number="15"></td>
        <td id="LC15" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L16" class="blob-line-num js-line-number" data-line-number="16"></td>
        <td id="LC16" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">float</span> <span class="n">FarClipPlane</span> <span class="p">=</span> <span class="m">100f</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L17" class="blob-line-num js-line-number" data-line-number="17"></td>
        <td id="LC17" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L18" class="blob-line-num js-line-number" data-line-number="18"></td>
        <td id="LC18" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">float</span> <span class="n">NearClipPlane</span> <span class="p">=</span> <span class="p">-</span><span class="m">1f</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L19" class="blob-line-num js-line-number" data-line-number="19"></td>
        <td id="LC19" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L20" class="blob-line-num js-line-number" data-line-number="20"></td>
        <td id="LC20" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">string</span> <span class="n">MeshesToChange</span> <span class="p">=</span> <span class="s">&quot;&quot;</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L21" class="blob-line-num js-line-number" data-line-number="21"></td>
        <td id="LC21" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L22" class="blob-line-num js-line-number" data-line-number="22"></td>
        <td id="LC22" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">bool</span> <span class="n">OneFacePerFrame</span> <span class="p">=</span> <span class="k">true</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L23" class="blob-line-num js-line-number" data-line-number="23"></td>
        <td id="LC23" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L24" class="blob-line-num js-line-number" data-line-number="24"></td>
        <td id="LC24" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">float</span> <span class="n">ParallaxHeight</span> <span class="p">=</span> <span class="m">0.02f</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L25" class="blob-line-num js-line-number" data-line-number="25"></td>
        <td id="LC25" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L26" class="blob-line-num js-line-number" data-line-number="26"></td>
        <td id="LC26" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">float</span> <span class="n">ReflectionStrength</span> <span class="p">=</span> <span class="m">1.0f</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L27" class="blob-line-num js-line-number" data-line-number="27"></td>
        <td id="LC27" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L28" class="blob-line-num js-line-number" data-line-number="28"></td>
        <td id="LC28" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="n">Color</span> <span class="n">ReflectionColor</span> <span class="p">=</span> <span class="k">new</span> <span class="n">Color</span><span class="p">(</span><span class="m">0.5f</span><span class="p">,</span> <span class="m">0.5f</span><span class="p">,</span> <span class="m">0.5f</span><span class="p">,</span> <span class="m">0.5f</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L29" class="blob-line-num js-line-number" data-line-number="29"></td>
        <td id="LC29" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L30" class="blob-line-num js-line-number" data-line-number="30"></td>
        <td id="LC30" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="n">Color</span> <span class="n">_Color</span> <span class="p">=</span> <span class="k">new</span> <span class="n">Color</span><span class="p">(</span><span class="m">1.0f</span><span class="p">,</span> <span class="m">1.0f</span><span class="p">,</span> <span class="m">1.0f</span><span class="p">,</span> <span class="m">1.0f</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L31" class="blob-line-num js-line-number" data-line-number="31"></td>
        <td id="LC31" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L32" class="blob-line-num js-line-number" data-line-number="32"></td>
        <td id="LC32" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">string</span> <span class="n">ShaderName</span> <span class="p">=</span> <span class="s">&quot;&quot;</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L33" class="blob-line-num js-line-number" data-line-number="33"></td>
        <td id="LC33" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L34" class="blob-line-num js-line-number" data-line-number="34"></td>
        <td id="LC34" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">float</span> <span class="n">Shininess</span> <span class="p">=</span> <span class="p">-</span><span class="m">1f</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L35" class="blob-line-num js-line-number" data-line-number="35"></td>
        <td id="LC35" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L36" class="blob-line-num js-line-number" data-line-number="36"></td>
        <td id="LC36" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">float</span> <span class="n">SpecColorA</span> <span class="p">=</span> <span class="m">0.5f</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L37" class="blob-line-num js-line-number" data-line-number="37"></td>
        <td id="LC37" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L38" class="blob-line-num js-line-number" data-line-number="38"></td>
        <td id="LC38" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">float</span> <span class="n">SpecColorB</span> <span class="p">=</span> <span class="m">0.5f</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L39" class="blob-line-num js-line-number" data-line-number="39"></td>
        <td id="LC39" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L40" class="blob-line-num js-line-number" data-line-number="40"></td>
        <td id="LC40" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">float</span> <span class="n">SpecColorG</span> <span class="p">=</span> <span class="m">0.5f</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L41" class="blob-line-num js-line-number" data-line-number="41"></td>
        <td id="LC41" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L42" class="blob-line-num js-line-number" data-line-number="42"></td>
        <td id="LC42" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">float</span> <span class="n">SpecColorR</span> <span class="p">=</span> <span class="p">-</span><span class="m">1f</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L43" class="blob-line-num js-line-number" data-line-number="43"></td>
        <td id="LC43" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L44" class="blob-line-num js-line-number" data-line-number="44"></td>
        <td id="LC44" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">float</span> <span class="n">rimFalloff</span> <span class="p">=</span> <span class="m">0</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L45" class="blob-line-num js-line-number" data-line-number="45"></td>
        <td id="LC45" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L46" class="blob-line-num js-line-number" data-line-number="46"></td>
        <td id="LC46" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="n">Color</span> <span class="n">rimColor</span> <span class="p">=</span> <span class="k">new</span> <span class="n">Color</span><span class="p">(</span><span class="m">0f</span><span class="p">,</span> <span class="m">0f</span><span class="p">,</span> <span class="m">0f</span><span class="p">,</span> <span class="m">0f</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L47" class="blob-line-num js-line-number" data-line-number="47"></td>
        <td id="LC47" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L48" class="blob-line-num js-line-number" data-line-number="48"></td>
        <td id="LC48" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">bool</span> <span class="n">realTimeReflection</span> <span class="p">=</span> <span class="k">true</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L49" class="blob-line-num js-line-number" data-line-number="49"></td>
        <td id="LC49" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false)]</span></td>
      </tr>
      <tr>
        <td id="L50" class="blob-line-num js-line-number" data-line-number="50"></td>
        <td id="LC50" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">double</span> <span class="n">updateRate</span> <span class="p">=</span> <span class="m">60.0</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L51" class="blob-line-num js-line-number" data-line-number="51"></td>
        <td id="LC51" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false, guiActive = false, guiName = &quot;Last Scene&quot;, guiUnits = &quot;&quot;, guiFormat = &quot;G&quot;)]</span></td>
      </tr>
      <tr>
        <td id="L52" class="blob-line-num js-line-number" data-line-number="52"></td>
        <td id="LC52" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">string</span> <span class="n">lastScene</span> <span class="p">=</span> <span class="s">&quot;&quot;</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L53" class="blob-line-num js-line-number" data-line-number="53"></td>
        <td id="LC53" class="blob-line-code js-file-line"><span class="na">        [KSPField(isPersistant = false, guiActive = false, guiName = &quot;Shader&quot;, guiUnits = &quot;&quot;, guiFormat = &quot;G&quot;)]</span></td>
      </tr>
      <tr>
        <td id="L54" class="blob-line-num js-line-number" data-line-number="54"></td>
        <td id="LC54" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="kt">string</span> <span class="n">scriptStatus</span> <span class="p">=</span> <span class="s">&quot;&quot;</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L55" class="blob-line-num js-line-number" data-line-number="55"></td>
        <td id="LC55" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L56" class="blob-line-num js-line-number" data-line-number="56"></td>
        <td id="LC56" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L57" class="blob-line-num js-line-number" data-line-number="57"></td>
        <td id="LC57" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L58" class="blob-line-num js-line-number" data-line-number="58"></td>
        <td id="LC58" class="blob-line-code js-file-line">        <span class="k">private</span> <span class="n">Shader</span> <span class="n">_rShader</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L59" class="blob-line-num js-line-number" data-line-number="59"></td>
        <td id="LC59" class="blob-line-code js-file-line">        <span class="k">private</span> <span class="n">ReflectiveScript</span> <span class="n">reflectiveScript</span> <span class="p">=</span> <span class="k">null</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L60" class="blob-line-num js-line-number" data-line-number="60"></td>
        <td id="LC60" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L61" class="blob-line-num js-line-number" data-line-number="61"></td>
        <td id="LC61" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="k">override</span> <span class="k">void</span> <span class="nf">OnStart</span><span class="p">(</span><span class="n">PartModule</span><span class="p">.</span><span class="n">StartState</span> <span class="n">state</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L62" class="blob-line-num js-line-number" data-line-number="62"></td>
        <td id="LC62" class="blob-line-code js-file-line">        <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L63" class="blob-line-num js-line-number" data-line-number="63"></td>
        <td id="LC63" class="blob-line-code js-file-line">            <span class="n">Debug</span><span class="p">.</span><span class="n">Log</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: Starting ReflectionPlugin .. &quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L64" class="blob-line-num js-line-number" data-line-number="64"></td>
        <td id="LC64" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="n">ShaderName</span> <span class="p">==</span> <span class="kt">string</span><span class="p">.</span><span class="n">Empty</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L65" class="blob-line-num js-line-number" data-line-number="65"></td>
        <td id="LC65" class="blob-line-code js-file-line">            <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L66" class="blob-line-num js-line-number" data-line-number="66"></td>
        <td id="LC66" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">Log</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: Defaulting shader to \&quot;Reflective/VertexLit\&quot;&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L67" class="blob-line-num js-line-number" data-line-number="67"></td>
        <td id="LC67" class="blob-line-code js-file-line">                <span class="k">this</span><span class="p">.</span><span class="n">ShaderName</span> <span class="p">=</span> <span class="s">&quot;Reflective/VertexLit&quot;</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L68" class="blob-line-num js-line-number" data-line-number="68"></td>
        <td id="LC68" class="blob-line-code js-file-line">            <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L69" class="blob-line-num js-line-number" data-line-number="69"></td>
        <td id="LC69" class="blob-line-code js-file-line">            <span class="k">this</span><span class="p">.</span><span class="n">_rShader</span> <span class="p">=</span> <span class="n">Shader</span><span class="p">.</span><span class="n">Find</span><span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="n">ShaderName</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L70" class="blob-line-num js-line-number" data-line-number="70"></td>
        <td id="LC70" class="blob-line-code js-file-line">            <span class="n">Shader</span> <span class="n">fallbackShader</span> <span class="p">=</span> <span class="n">Shader</span><span class="p">.</span><span class="n">Find</span><span class="p">(</span><span class="s">&quot;Reflective/VertexLit&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L71" class="blob-line-num js-line-number" data-line-number="71"></td>
        <td id="LC71" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L72" class="blob-line-num js-line-number" data-line-number="72"></td>
        <td id="LC72" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="p">((</span><span class="n">UnityEngine</span><span class="p">.</span><span class="n">Object</span><span class="p">)</span><span class="k">this</span><span class="p">.</span><span class="n">_rShader</span> <span class="p">==</span> <span class="p">(</span><span class="n">UnityEngine</span><span class="p">.</span><span class="n">Object</span><span class="p">)</span><span class="k">null</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L73" class="blob-line-num js-line-number" data-line-number="73"></td>
        <td id="LC73" class="blob-line-code js-file-line">            <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L74" class="blob-line-num js-line-number" data-line-number="74"></td>
        <td id="LC74" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">LogWarning</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="kt">string</span><span class="p">.</span><span class="n">Format</span><span class="p">(</span><span class="s">&quot;RP: Could not find the specified shader \&quot;{0}\&quot;.&quot;</span><span class="p">,</span> <span class="p">(</span><span class="kt">object</span><span class="p">)</span><span class="k">this</span><span class="p">.</span><span class="n">ShaderName</span><span class="p">));</span></td>
      </tr>
      <tr>
        <td id="L75" class="blob-line-num js-line-number" data-line-number="75"></td>
        <td id="LC75" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">LogWarning</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: Simple reflective shaders:&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L76" class="blob-line-num js-line-number" data-line-number="76"></td>
        <td id="LC76" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">LogWarning</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: -\&quot;Reflective/Diffuse\&quot;&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L77" class="blob-line-num js-line-number" data-line-number="77"></td>
        <td id="LC77" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">LogWarning</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: -\&quot;Reflective/Specular\&quot;&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L78" class="blob-line-num js-line-number" data-line-number="78"></td>
        <td id="LC78" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">LogWarning</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: -\&quot;Reflective/VertexLit\&quot;&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L79" class="blob-line-num js-line-number" data-line-number="79"></td>
        <td id="LC79" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">LogWarning</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: Advanced reflective shaders:&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L80" class="blob-line-num js-line-number" data-line-number="80"></td>
        <td id="LC80" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">LogWarning</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: -\&quot;Reflective/Bumped Diffuse\&quot;&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L81" class="blob-line-num js-line-number" data-line-number="81"></td>
        <td id="LC81" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">LogWarning</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: -\&quot;Reflective/Bumped Specular\&quot;&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L82" class="blob-line-num js-line-number" data-line-number="82"></td>
        <td id="LC82" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">LogWarning</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: -\&quot;Reflective/Bumped Unlit\&quot;&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L83" class="blob-line-num js-line-number" data-line-number="83"></td>
        <td id="LC83" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">LogWarning</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: -\&quot;Reflective/Bumped VertexLit\&quot;&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L84" class="blob-line-num js-line-number" data-line-number="84"></td>
        <td id="LC84" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">LogWarning</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: -\&quot;Reflective/Parallax Diffuse\&quot;&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L85" class="blob-line-num js-line-number" data-line-number="85"></td>
        <td id="LC85" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">LogWarning</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: -\&quot;Reflective/Parallax Specular\&quot;&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L86" class="blob-line-num js-line-number" data-line-number="86"></td>
        <td id="LC86" class="blob-line-code js-file-line">                <span class="c1">// Try to handle fallback later during material building</span></td>
      </tr>
      <tr>
        <td id="L87" class="blob-line-num js-line-number" data-line-number="87"></td>
        <td id="LC87" class="blob-line-code js-file-line">                <span class="c1">// This is so we can try to load and deserialize missing shaders from compiled shader code.</span></td>
      </tr>
      <tr>
        <td id="L88" class="blob-line-num js-line-number" data-line-number="88"></td>
        <td id="LC88" class="blob-line-code js-file-line">                <span class="k">this</span><span class="p">.</span><span class="n">_rShader</span> <span class="p">=</span> <span class="k">null</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L89" class="blob-line-num js-line-number" data-line-number="89"></td>
        <td id="LC89" class="blob-line-code js-file-line">                <span class="c1">//this._rShader = Shader.Find(this.ShaderName);</span></td>
      </tr>
      <tr>
        <td id="L90" class="blob-line-num js-line-number" data-line-number="90"></td>
        <td id="LC90" class="blob-line-code js-file-line">                <span class="c1">//if ((UnityEngine.Object)this._rShader == (UnityEngine.Object)null)</span></td>
      </tr>
      <tr>
        <td id="L91" class="blob-line-num js-line-number" data-line-number="91"></td>
        <td id="LC91" class="blob-line-code js-file-line">                <span class="c1">//{</span></td>
      </tr>
      <tr>
        <td id="L92" class="blob-line-num js-line-number" data-line-number="92"></td>
        <td id="LC92" class="blob-line-code js-file-line">                <span class="c1">//    Debug.LogWarning((object)&quot;RP: Fallback shader VertexLit failed.&quot;);</span></td>
      </tr>
      <tr>
        <td id="L93" class="blob-line-num js-line-number" data-line-number="93"></td>
        <td id="LC93" class="blob-line-code js-file-line">                <span class="c1">//}</span></td>
      </tr>
      <tr>
        <td id="L94" class="blob-line-num js-line-number" data-line-number="94"></td>
        <td id="LC94" class="blob-line-code js-file-line">            <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L95" class="blob-line-num js-line-number" data-line-number="95"></td>
        <td id="LC95" class="blob-line-code js-file-line">            <span class="k">else</span></td>
      </tr>
      <tr>
        <td id="L96" class="blob-line-num js-line-number" data-line-number="96"></td>
        <td id="LC96" class="blob-line-code js-file-line">            <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L97" class="blob-line-num js-line-number" data-line-number="97"></td>
        <td id="LC97" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">LogWarning</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="kt">string</span><span class="p">.</span><span class="n">Format</span><span class="p">(</span><span class="s">&quot;RP: Found shader \&quot;{0}\&quot;.&quot;</span><span class="p">,</span> <span class="p">(</span><span class="kt">object</span><span class="p">)</span><span class="k">this</span><span class="p">.</span><span class="n">_rShader</span><span class="p">.</span><span class="n">name</span><span class="p">));</span></td>
      </tr>
      <tr>
        <td id="L98" class="blob-line-num js-line-number" data-line-number="98"></td>
        <td id="LC98" class="blob-line-code js-file-line">            <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L99" class="blob-line-num js-line-number" data-line-number="99"></td>
        <td id="LC99" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L100" class="blob-line-num js-line-number" data-line-number="100"></td>
        <td id="LC100" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="n">MeshesToChange</span> <span class="p">==</span> <span class="kt">string</span><span class="p">.</span><span class="n">Empty</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L101" class="blob-line-num js-line-number" data-line-number="101"></td>
        <td id="LC101" class="blob-line-code js-file-line">            <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L102" class="blob-line-num js-line-number" data-line-number="102"></td>
        <td id="LC102" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">Log</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: Applying changes to part ..&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L103" class="blob-line-num js-line-number" data-line-number="103"></td>
        <td id="LC103" class="blob-line-code js-file-line">                <span class="k">this</span><span class="p">.</span><span class="n">ReplaceShader</span><span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="n">part</span><span class="p">.</span><span class="n">FindModelComponent</span><span class="p">&lt;</span><span class="n">UnityEngine</span><span class="p">.</span><span class="n">Renderer</span><span class="p">&gt;());</span></td>
      </tr>
      <tr>
        <td id="L104" class="blob-line-num js-line-number" data-line-number="104"></td>
        <td id="LC104" class="blob-line-code js-file-line">            <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L105" class="blob-line-num js-line-number" data-line-number="105"></td>
        <td id="LC105" class="blob-line-code js-file-line">            <span class="k">else</span></td>
      </tr>
      <tr>
        <td id="L106" class="blob-line-num js-line-number" data-line-number="106"></td>
        <td id="LC106" class="blob-line-code js-file-line">            <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L107" class="blob-line-num js-line-number" data-line-number="107"></td>
        <td id="LC107" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">Log</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: Applying changes to meshes ..&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L108" class="blob-line-num js-line-number" data-line-number="108"></td>
        <td id="LC108" class="blob-line-code js-file-line">                <span class="n">List</span><span class="p">&lt;</span><span class="kt">string</span><span class="p">&gt;</span> <span class="n">meshNamesList</span> <span class="p">=</span> <span class="n">Enumerable</span><span class="p">.</span><span class="n">ToList</span><span class="p">&lt;</span><span class="kt">string</span><span class="p">&gt;((</span><span class="n">IEnumerable</span><span class="p">&lt;</span><span class="kt">string</span><span class="p">&gt;)</span><span class="k">this</span><span class="p">.</span><span class="n">MeshesToChange</span><span class="p">.</span><span class="n">Split</span><span class="p">(</span><span class="k">new</span> <span class="kt">char</span><span class="p">[</span><span class="m">1</span><span class="p">]</span> <span class="p">{</span> <span class="sc">&#39;,&#39;</span> <span class="p">}));</span></td>
      </tr>
      <tr>
        <td id="L109" class="blob-line-num js-line-number" data-line-number="109"></td>
        <td id="LC109" class="blob-line-code js-file-line">                <span class="n">MeshFilter</span><span class="p">[]</span> <span class="n">modelComponents</span> <span class="p">=</span> <span class="k">this</span><span class="p">.</span><span class="n">part</span><span class="p">.</span><span class="n">FindModelComponents</span><span class="p">&lt;</span><span class="n">MeshFilter</span><span class="p">&gt;();</span></td>
      </tr>
      <tr>
        <td id="L110" class="blob-line-num js-line-number" data-line-number="110"></td>
        <td id="LC110" class="blob-line-code js-file-line">                <span class="k">if</span> <span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="n">MeshesToChange</span> <span class="p">==</span> <span class="s">&quot;all&quot;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L111" class="blob-line-num js-line-number" data-line-number="111"></td>
        <td id="LC111" class="blob-line-code js-file-line">                <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L112" class="blob-line-num js-line-number" data-line-number="112"></td>
        <td id="LC112" class="blob-line-code js-file-line">                    <span class="k">foreach</span> <span class="p">(</span><span class="n">MeshFilter</span> <span class="n">meshFilter</span> <span class="k">in</span> <span class="n">modelComponents</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L113" class="blob-line-num js-line-number" data-line-number="113"></td>
        <td id="LC113" class="blob-line-code js-file-line">                    <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L114" class="blob-line-num js-line-number" data-line-number="114"></td>
        <td id="LC114" class="blob-line-code js-file-line">                        <span class="n">Debug</span><span class="p">.</span><span class="n">Log</span><span class="p">((</span><span class="kt">object</span><span class="p">)(</span><span class="s">&quot;RP: Applying changes to mesh: &quot;</span> <span class="p">+</span> <span class="n">meshFilter</span><span class="p">.</span><span class="n">name</span><span class="p">));</span></td>
      </tr>
      <tr>
        <td id="L115" class="blob-line-num js-line-number" data-line-number="115"></td>
        <td id="LC115" class="blob-line-code js-file-line">                        <span class="k">this</span><span class="p">.</span><span class="n">ReplaceShader</span><span class="p">(</span><span class="n">meshFilter</span><span class="p">.</span><span class="n">GetComponent</span><span class="p">&lt;</span><span class="n">UnityEngine</span><span class="p">.</span><span class="n">Renderer</span><span class="p">&gt;());</span></td>
      </tr>
      <tr>
        <td id="L116" class="blob-line-num js-line-number" data-line-number="116"></td>
        <td id="LC116" class="blob-line-code js-file-line">                    <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L117" class="blob-line-num js-line-number" data-line-number="117"></td>
        <td id="LC117" class="blob-line-code js-file-line">                <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L118" class="blob-line-num js-line-number" data-line-number="118"></td>
        <td id="LC118" class="blob-line-code js-file-line">                <span class="k">else</span></td>
      </tr>
      <tr>
        <td id="L119" class="blob-line-num js-line-number" data-line-number="119"></td>
        <td id="LC119" class="blob-line-code js-file-line">                <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L120" class="blob-line-num js-line-number" data-line-number="120"></td>
        <td id="LC120" class="blob-line-code js-file-line">                    <span class="k">foreach</span> <span class="p">(</span><span class="n">MeshFilter</span> <span class="n">meshFilter</span> <span class="k">in</span> <span class="n">Enumerable</span><span class="p">.</span><span class="n">Where</span><span class="p">&lt;</span><span class="n">MeshFilter</span><span class="p">&gt;((</span><span class="n">IEnumerable</span><span class="p">&lt;</span><span class="n">MeshFilter</span><span class="p">&gt;)</span><span class="n">modelComponents</span><span class="p">,</span> <span class="p">(</span><span class="n">Func</span><span class="p">&lt;</span><span class="n">MeshFilter</span><span class="p">,</span> <span class="kt">bool</span><span class="p">&gt;)(</span><span class="n">mesh</span> <span class="p">=&gt;</span> <span class="n">meshNamesList</span><span class="p">.</span><span class="n">Contains</span><span class="p">(</span><span class="n">mesh</span><span class="p">.</span><span class="n">name</span><span class="p">))))</span></td>
      </tr>
      <tr>
        <td id="L121" class="blob-line-num js-line-number" data-line-number="121"></td>
        <td id="LC121" class="blob-line-code js-file-line">                    <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L122" class="blob-line-num js-line-number" data-line-number="122"></td>
        <td id="LC122" class="blob-line-code js-file-line">                        <span class="n">Debug</span><span class="p">.</span><span class="n">Log</span><span class="p">((</span><span class="kt">object</span><span class="p">)(</span><span class="s">&quot;RP: Applying changes to mesh: &quot;</span> <span class="p">+</span> <span class="n">meshFilter</span><span class="p">.</span><span class="n">name</span><span class="p">));</span></td>
      </tr>
      <tr>
        <td id="L123" class="blob-line-num js-line-number" data-line-number="123"></td>
        <td id="LC123" class="blob-line-code js-file-line">                        <span class="k">this</span><span class="p">.</span><span class="n">ReplaceShader</span><span class="p">(</span><span class="n">meshFilter</span><span class="p">.</span><span class="n">GetComponent</span><span class="p">&lt;</span><span class="n">UnityEngine</span><span class="p">.</span><span class="n">Renderer</span><span class="p">&gt;());</span></td>
      </tr>
      <tr>
        <td id="L124" class="blob-line-num js-line-number" data-line-number="124"></td>
        <td id="LC124" class="blob-line-code js-file-line">                    <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L125" class="blob-line-num js-line-number" data-line-number="125"></td>
        <td id="LC125" class="blob-line-code js-file-line">                <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L126" class="blob-line-num js-line-number" data-line-number="126"></td>
        <td id="LC126" class="blob-line-code js-file-line">            <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L127" class="blob-line-num js-line-number" data-line-number="127"></td>
        <td id="LC127" class="blob-line-code js-file-line">            <span class="n">Debug</span><span class="p">.</span><span class="n">Log</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: Done.&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L128" class="blob-line-num js-line-number" data-line-number="128"></td>
        <td id="LC128" class="blob-line-code js-file-line">        <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L129" class="blob-line-num js-line-number" data-line-number="129"></td>
        <td id="LC129" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L130" class="blob-line-num js-line-number" data-line-number="130"></td>
        <td id="LC130" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L131" class="blob-line-num js-line-number" data-line-number="131"></td>
        <td id="LC131" class="blob-line-code js-file-line">        <span class="k">private</span> <span class="k">void</span> <span class="nf">ReplaceShader</span><span class="p">(</span><span class="n">UnityEngine</span><span class="p">.</span><span class="n">Renderer</span> <span class="n">pRenderer</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L132" class="blob-line-num js-line-number" data-line-number="132"></td>
        <td id="LC132" class="blob-line-code js-file-line">        <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L133" class="blob-line-num js-line-number" data-line-number="133"></td>
        <td id="LC133" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="p">((</span><span class="n">UnityEngine</span><span class="p">.</span><span class="n">Object</span><span class="p">)</span><span class="n">pRenderer</span> <span class="p">!=</span> <span class="p">(</span><span class="n">UnityEngine</span><span class="p">.</span><span class="n">Object</span><span class="p">)</span><span class="k">null</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L134" class="blob-line-num js-line-number" data-line-number="134"></td>
        <td id="LC134" class="blob-line-code js-file-line">            <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L135" class="blob-line-num js-line-number" data-line-number="135"></td>
        <td id="LC135" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">Log</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="kt">string</span><span class="p">.</span><span class="n">Format</span><span class="p">(</span><span class="s">&quot;RP: Renderer found: {0}&quot;</span><span class="p">,</span> <span class="p">(</span><span class="kt">object</span><span class="p">)</span><span class="k">this</span><span class="p">.</span><span class="n">_rShader</span><span class="p">));</span></td>
      </tr>
      <tr>
        <td id="L136" class="blob-line-num js-line-number" data-line-number="136"></td>
        <td id="LC136" class="blob-line-code js-file-line">                <span class="n">Material</span> <span class="n">material</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L137" class="blob-line-num js-line-number" data-line-number="137"></td>
        <td id="LC137" class="blob-line-code js-file-line">                <span class="k">if</span> <span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="n">_rShader</span> <span class="p">==</span> <span class="k">null</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L138" class="blob-line-num js-line-number" data-line-number="138"></td>
        <td id="LC138" class="blob-line-code js-file-line">                <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L139" class="blob-line-num js-line-number" data-line-number="139"></td>
        <td id="LC139" class="blob-line-code js-file-line">                    <span class="n">Debug</span><span class="p">.</span><span class="n">Log</span><span class="p">((</span><span class="kt">object</span><span class="p">)(</span><span class="s">&quot;RP: null shader. Trying to retrieve ReflectionPlugin.Shaders.&quot;</span> <span class="p">+</span> <span class="k">this</span><span class="p">.</span><span class="n">ShaderName</span><span class="p">));</span></td>
      </tr>
      <tr>
        <td id="L140" class="blob-line-num js-line-number" data-line-number="140"></td>
        <td id="LC140" class="blob-line-code js-file-line">                    <span class="n">Assembly</span> <span class="n">assembly</span> <span class="p">=</span> <span class="n">Assembly</span><span class="p">.</span><span class="n">GetExecutingAssembly</span><span class="p">();</span></td>
      </tr>
      <tr>
        <td id="L141" class="blob-line-num js-line-number" data-line-number="141"></td>
        <td id="LC141" class="blob-line-code js-file-line">                    <span class="n">StreamReader</span> <span class="n">shaderStreamReader</span> <span class="p">=</span> <span class="k">new</span> <span class="n">StreamReader</span><span class="p">(</span><span class="n">assembly</span><span class="p">.</span><span class="n">GetManifestResourceStream</span><span class="p">(</span><span class="cm">/*&quot;ReflectionPlugin.Shaders.&quot; + */</span><span class="k">this</span><span class="p">.</span><span class="n">ShaderName</span><span class="p">));</span></td>
      </tr>
      <tr>
        <td id="L142" class="blob-line-num js-line-number" data-line-number="142"></td>
        <td id="LC142" class="blob-line-code js-file-line">                    <span class="k">if</span> <span class="p">(</span><span class="n">shaderStreamReader</span> <span class="p">!=</span> <span class="k">null</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L143" class="blob-line-num js-line-number" data-line-number="143"></td>
        <td id="LC143" class="blob-line-code js-file-line">                    <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L144" class="blob-line-num js-line-number" data-line-number="144"></td>
        <td id="LC144" class="blob-line-code js-file-line">                        <span class="n">material</span> <span class="p">=</span> <span class="k">new</span> <span class="n">Material</span><span class="p">(</span><span class="n">shaderStreamReader</span><span class="p">.</span><span class="n">ReadToEnd</span><span class="p">())</span></td>
      </tr>
      <tr>
        <td id="L145" class="blob-line-num js-line-number" data-line-number="145"></td>
        <td id="LC145" class="blob-line-code js-file-line">                        <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L146" class="blob-line-num js-line-number" data-line-number="146"></td>
        <td id="LC146" class="blob-line-code js-file-line">                            <span class="n">mainTexture</span> <span class="p">=</span> <span class="n">pRenderer</span><span class="p">.</span><span class="n">material</span><span class="p">.</span><span class="n">mainTexture</span></td>
      </tr>
      <tr>
        <td id="L147" class="blob-line-num js-line-number" data-line-number="147"></td>
        <td id="LC147" class="blob-line-code js-file-line">                        <span class="p">};</span></td>
      </tr>
      <tr>
        <td id="L148" class="blob-line-num js-line-number" data-line-number="148"></td>
        <td id="LC148" class="blob-line-code js-file-line">                    <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L149" class="blob-line-num js-line-number" data-line-number="149"></td>
        <td id="LC149" class="blob-line-code js-file-line">                    <span class="k">else</span></td>
      </tr>
      <tr>
        <td id="L150" class="blob-line-num js-line-number" data-line-number="150"></td>
        <td id="LC150" class="blob-line-code js-file-line">                    <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L151" class="blob-line-num js-line-number" data-line-number="151"></td>
        <td id="LC151" class="blob-line-code js-file-line">                        <span class="n">material</span> <span class="p">=</span> <span class="k">new</span> <span class="n">Material</span><span class="p">(</span><span class="n">Shader</span><span class="p">.</span><span class="n">Find</span><span class="p">(</span><span class="s">&quot;Reflective/VertexList&quot;</span><span class="p">))</span></td>
      </tr>
      <tr>
        <td id="L152" class="blob-line-num js-line-number" data-line-number="152"></td>
        <td id="LC152" class="blob-line-code js-file-line">                        <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L153" class="blob-line-num js-line-number" data-line-number="153"></td>
        <td id="LC153" class="blob-line-code js-file-line">                            <span class="n">mainTexture</span> <span class="p">=</span> <span class="n">pRenderer</span><span class="p">.</span><span class="n">material</span><span class="p">.</span><span class="n">mainTexture</span></td>
      </tr>
      <tr>
        <td id="L154" class="blob-line-num js-line-number" data-line-number="154"></td>
        <td id="LC154" class="blob-line-code js-file-line">                        <span class="p">};</span></td>
      </tr>
      <tr>
        <td id="L155" class="blob-line-num js-line-number" data-line-number="155"></td>
        <td id="LC155" class="blob-line-code js-file-line">                    <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L156" class="blob-line-num js-line-number" data-line-number="156"></td>
        <td id="LC156" class="blob-line-code js-file-line">                <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L157" class="blob-line-num js-line-number" data-line-number="157"></td>
        <td id="LC157" class="blob-line-code js-file-line">                <span class="k">else</span></td>
      </tr>
      <tr>
        <td id="L158" class="blob-line-num js-line-number" data-line-number="158"></td>
        <td id="LC158" class="blob-line-code js-file-line">                <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L159" class="blob-line-num js-line-number" data-line-number="159"></td>
        <td id="LC159" class="blob-line-code js-file-line">                    <span class="n">material</span> <span class="p">=</span> <span class="k">new</span> <span class="n">Material</span><span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="n">_rShader</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L160" class="blob-line-num js-line-number" data-line-number="160"></td>
        <td id="LC160" class="blob-line-code js-file-line">                    <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L161" class="blob-line-num js-line-number" data-line-number="161"></td>
        <td id="LC161" class="blob-line-code js-file-line">                        <span class="n">mainTexture</span> <span class="p">=</span> <span class="n">pRenderer</span><span class="p">.</span><span class="n">material</span><span class="p">.</span><span class="n">mainTexture</span></td>
      </tr>
      <tr>
        <td id="L162" class="blob-line-num js-line-number" data-line-number="162"></td>
        <td id="LC162" class="blob-line-code js-file-line">                    <span class="p">};</span></td>
      </tr>
      <tr>
        <td id="L163" class="blob-line-num js-line-number" data-line-number="163"></td>
        <td id="LC163" class="blob-line-code js-file-line">                <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L164" class="blob-line-num js-line-number" data-line-number="164"></td>
        <td id="LC164" class="blob-line-code js-file-line">                <span class="n">Texture</span> <span class="n">texture1</span> <span class="p">=</span> <span class="n">pRenderer</span><span class="p">.</span><span class="n">material</span><span class="p">.</span><span class="n">GetTexture</span><span class="p">(</span><span class="s">&quot;_BumpMap&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L165" class="blob-line-num js-line-number" data-line-number="165"></td>
        <td id="LC165" class="blob-line-code js-file-line">                <span class="n">Texture</span> <span class="n">texture2</span> <span class="p">=</span> <span class="n">pRenderer</span><span class="p">.</span><span class="n">material</span><span class="p">.</span><span class="n">GetTexture</span><span class="p">(</span><span class="s">&quot;_Emissive&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L166" class="blob-line-num js-line-number" data-line-number="166"></td>
        <td id="LC166" class="blob-line-code js-file-line">                <span class="k">if</span> <span class="p">((</span><span class="n">UnityEngine</span><span class="p">.</span><span class="n">Object</span><span class="p">)</span><span class="n">texture1</span> <span class="p">!=</span> <span class="p">(</span><span class="n">UnityEngine</span><span class="p">.</span><span class="n">Object</span><span class="p">)</span><span class="k">null</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L167" class="blob-line-num js-line-number" data-line-number="167"></td>
        <td id="LC167" class="blob-line-code js-file-line">                <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L168" class="blob-line-num js-line-number" data-line-number="168"></td>
        <td id="LC168" class="blob-line-code js-file-line">                    <span class="n">Debug</span><span class="p">.</span><span class="n">LogWarning</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: Found bumpmap texture, applying..&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L169" class="blob-line-num js-line-number" data-line-number="169"></td>
        <td id="LC169" class="blob-line-code js-file-line">                    <span class="n">material</span><span class="p">.</span><span class="n">SetTexture</span><span class="p">(</span><span class="s">&quot;_BumpMap&quot;</span><span class="p">,</span> <span class="n">texture1</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L170" class="blob-line-num js-line-number" data-line-number="170"></td>
        <td id="LC170" class="blob-line-code js-file-line">                    <span class="n">material</span><span class="p">.</span><span class="n">SetTextureScale</span><span class="p">(</span><span class="s">&quot;_BumpMap&quot;</span><span class="p">,</span> <span class="n">pRenderer</span><span class="p">.</span><span class="n">material</span><span class="p">.</span><span class="n">GetTextureScale</span><span class="p">(</span><span class="s">&quot;_BumpMap&quot;</span><span class="p">));</span></td>
      </tr>
      <tr>
        <td id="L171" class="blob-line-num js-line-number" data-line-number="171"></td>
        <td id="LC171" class="blob-line-code js-file-line">                <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L172" class="blob-line-num js-line-number" data-line-number="172"></td>
        <td id="LC172" class="blob-line-code js-file-line">                <span class="k">if</span> <span class="p">((</span><span class="n">UnityEngine</span><span class="p">.</span><span class="n">Object</span><span class="p">)</span><span class="n">texture2</span> <span class="p">!=</span> <span class="p">(</span><span class="n">UnityEngine</span><span class="p">.</span><span class="n">Object</span><span class="p">)</span><span class="k">null</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L173" class="blob-line-num js-line-number" data-line-number="173"></td>
        <td id="LC173" class="blob-line-code js-file-line">                <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L174" class="blob-line-num js-line-number" data-line-number="174"></td>
        <td id="LC174" class="blob-line-code js-file-line">                    <span class="n">Debug</span><span class="p">.</span><span class="n">LogWarning</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: Found heightmap texture, applying..&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L175" class="blob-line-num js-line-number" data-line-number="175"></td>
        <td id="LC175" class="blob-line-code js-file-line">                    <span class="n">material</span><span class="p">.</span><span class="n">SetTexture</span><span class="p">(</span><span class="s">&quot;_ParallaxMap&quot;</span><span class="p">,</span> <span class="n">texture2</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L176" class="blob-line-num js-line-number" data-line-number="176"></td>
        <td id="LC176" class="blob-line-code js-file-line">                    <span class="n">material</span><span class="p">.</span><span class="n">SetFloat</span><span class="p">(</span><span class="s">&quot;_Parallax&quot;</span><span class="p">,</span> <span class="p">(</span><span class="kt">double</span><span class="p">)</span><span class="k">this</span><span class="p">.</span><span class="n">ParallaxHeight</span> <span class="p">&lt;</span> <span class="m">0.00499999988824129</span> <span class="p">||</span> <span class="p">(</span><span class="kt">double</span><span class="p">)</span><span class="k">this</span><span class="p">.</span><span class="n">ParallaxHeight</span> <span class="p">&gt;</span> <span class="m">0.0799999982118607</span> <span class="p">?</span> <span class="m">0.02f</span> <span class="p">:</span> <span class="k">this</span><span class="p">.</span><span class="n">ParallaxHeight</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L177" class="blob-line-num js-line-number" data-line-number="177"></td>
        <td id="LC177" class="blob-line-code js-file-line">                    <span class="n">material</span><span class="p">.</span><span class="n">SetTextureScale</span><span class="p">(</span><span class="s">&quot;_Parallax&quot;</span><span class="p">,</span> <span class="n">pRenderer</span><span class="p">.</span><span class="n">material</span><span class="p">.</span><span class="n">GetTextureScale</span><span class="p">(</span><span class="s">&quot;_Parallax&quot;</span><span class="p">));</span></td>
      </tr>
      <tr>
        <td id="L178" class="blob-line-num js-line-number" data-line-number="178"></td>
        <td id="LC178" class="blob-line-code js-file-line">                <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L179" class="blob-line-num js-line-number" data-line-number="179"></td>
        <td id="LC179" class="blob-line-code js-file-line">                <span class="c1">//try</span></td>
      </tr>
      <tr>
        <td id="L180" class="blob-line-num js-line-number" data-line-number="180"></td>
        <td id="LC180" class="blob-line-code js-file-line">                <span class="c1">//{</span></td>
      </tr>
      <tr>
        <td id="L181" class="blob-line-num js-line-number" data-line-number="181"></td>
        <td id="LC181" class="blob-line-code js-file-line">                <span class="n">print</span><span class="p">(</span><span class="s">&quot;RP: Set _Shininess&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L182" class="blob-line-num js-line-number" data-line-number="182"></td>
        <td id="LC182" class="blob-line-code js-file-line">                <span class="n">material</span><span class="p">.</span><span class="n">SetFloat</span><span class="p">(</span><span class="s">&quot;_Shininess&quot;</span><span class="p">,</span> <span class="p">(</span><span class="kt">double</span><span class="p">)</span><span class="k">this</span><span class="p">.</span><span class="n">Shininess</span> <span class="p">&lt;</span> <span class="m">0.0</span> <span class="p">?</span> <span class="n">pRenderer</span><span class="p">.</span><span class="n">material</span><span class="p">.</span><span class="n">GetFloat</span><span class="p">(</span><span class="s">&quot;_Shininess&quot;</span><span class="p">)</span> <span class="p">:</span> <span class="k">this</span><span class="p">.</span><span class="n">Shininess</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L183" class="blob-line-num js-line-number" data-line-number="183"></td>
        <td id="LC183" class="blob-line-code js-file-line">                <span class="n">print</span><span class="p">(</span><span class="s">&quot;RP: Set _SpecColor&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L184" class="blob-line-num js-line-number" data-line-number="184"></td>
        <td id="LC184" class="blob-line-code js-file-line">                <span class="n">material</span><span class="p">.</span><span class="n">SetColor</span><span class="p">(</span><span class="s">&quot;_SpecColor&quot;</span><span class="p">,</span> <span class="p">(</span><span class="kt">double</span><span class="p">)</span><span class="k">this</span><span class="p">.</span><span class="n">SpecColorR</span> <span class="p">&lt;</span> <span class="m">0.0</span> <span class="p">?</span> <span class="n">pRenderer</span><span class="p">.</span><span class="n">material</span><span class="p">.</span><span class="n">GetColor</span><span class="p">(</span><span class="s">&quot;_SpecColor&quot;</span><span class="p">)</span> <span class="p">:</span> <span class="k">new</span> <span class="n">Color</span><span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="n">SpecColorR</span><span class="p">,</span> <span class="k">this</span><span class="p">.</span><span class="n">SpecColorG</span><span class="p">,</span> <span class="k">this</span><span class="p">.</span><span class="n">SpecColorB</span><span class="p">,</span> <span class="k">this</span><span class="p">.</span><span class="n">SpecColorA</span><span class="p">));</span></td>
      </tr>
      <tr>
        <td id="L185" class="blob-line-num js-line-number" data-line-number="185"></td>
        <td id="LC185" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L186" class="blob-line-num js-line-number" data-line-number="186"></td>
        <td id="LC186" class="blob-line-code js-file-line">                <span class="c1">// -1 for ReflectionStrength will actually use ReflectionColor, Individual RGB(A???) values can be set in config.</span></td>
      </tr>
      <tr>
        <td id="L187" class="blob-line-num js-line-number" data-line-number="187"></td>
        <td id="LC187" class="blob-line-code js-file-line">                <span class="k">if</span> <span class="p">(</span><span class="n">ReflectionStrength</span> <span class="p">&lt;</span> <span class="m">0f</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L188" class="blob-line-num js-line-number" data-line-number="188"></td>
        <td id="LC188" class="blob-line-code js-file-line">                <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L189" class="blob-line-num js-line-number" data-line-number="189"></td>
        <td id="LC189" class="blob-line-code js-file-line">                    <span class="n">print</span><span class="p">(</span><span class="s">&quot;RP: Set _ReflectColor: &quot;</span> <span class="p">+</span> <span class="n">ReflectionColor</span><span class="p">.</span><span class="n">ToString</span><span class="p">());</span></td>
      </tr>
      <tr>
        <td id="L190" class="blob-line-num js-line-number" data-line-number="190"></td>
        <td id="LC190" class="blob-line-code js-file-line">                    <span class="n">material</span><span class="p">.</span><span class="n">SetColor</span><span class="p">(</span><span class="s">&quot;_ReflectColor&quot;</span><span class="p">,</span> <span class="n">ReflectionColor</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L191" class="blob-line-num js-line-number" data-line-number="191"></td>
        <td id="LC191" class="blob-line-code js-file-line">                <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L192" class="blob-line-num js-line-number" data-line-number="192"></td>
        <td id="LC192" class="blob-line-code js-file-line">                <span class="k">else</span></td>
      </tr>
      <tr>
        <td id="L193" class="blob-line-num js-line-number" data-line-number="193"></td>
        <td id="LC193" class="blob-line-code js-file-line">                <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L194" class="blob-line-num js-line-number" data-line-number="194"></td>
        <td id="LC194" class="blob-line-code js-file-line">                    <span class="n">print</span><span class="p">(</span><span class="s">&quot;RP: Set _ReflectColor (ReflectionStrength: &quot;</span> <span class="p">+</span> <span class="k">this</span><span class="p">.</span><span class="n">ReflectionStrength</span><span class="p">.</span><span class="n">ToString</span><span class="p">()</span> <span class="p">+</span> <span class="s">&quot;)&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L195" class="blob-line-num js-line-number" data-line-number="195"></td>
        <td id="LC195" class="blob-line-code js-file-line">                    <span class="n">material</span><span class="p">.</span><span class="n">SetColor</span><span class="p">(</span><span class="s">&quot;_ReflectColor&quot;</span><span class="p">,</span> <span class="k">new</span> <span class="n">Color</span><span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="n">ReflectionStrength</span><span class="p">,</span> <span class="k">this</span><span class="p">.</span><span class="n">ReflectionStrength</span><span class="p">,</span> <span class="k">this</span><span class="p">.</span><span class="n">ReflectionStrength</span><span class="p">,</span> <span class="k">this</span><span class="p">.</span><span class="n">ReflectionStrength</span><span class="p">));</span></td>
      </tr>
      <tr>
        <td id="L196" class="blob-line-num js-line-number" data-line-number="196"></td>
        <td id="LC196" class="blob-line-code js-file-line">                <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L197" class="blob-line-num js-line-number" data-line-number="197"></td>
        <td id="LC197" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L198" class="blob-line-num js-line-number" data-line-number="198"></td>
        <td id="LC198" class="blob-line-code js-file-line">                <span class="n">print</span><span class="p">(</span><span class="s">&quot;RP: Set _Color&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L199" class="blob-line-num js-line-number" data-line-number="199"></td>
        <td id="LC199" class="blob-line-code js-file-line">                <span class="n">material</span><span class="p">.</span><span class="n">SetColor</span><span class="p">(</span><span class="s">&quot;_Color&quot;</span><span class="p">,</span> <span class="n">_Color</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L200" class="blob-line-num js-line-number" data-line-number="200"></td>
        <td id="LC200" class="blob-line-code js-file-line">                <span class="c1">// rim lighting experiment. Useless for Unity reflective shaders; only the KSP versions have it. Disabled as it requires setting to KSP shaders.</span></td>
      </tr>
      <tr>
        <td id="L201" class="blob-line-num js-line-number" data-line-number="201"></td>
        <td id="LC201" class="blob-line-code js-file-line">                <span class="c1">//material.SetFloat(&quot;_RimFalloff&quot;, rimFalloff);</span></td>
      </tr>
      <tr>
        <td id="L202" class="blob-line-num js-line-number" data-line-number="202"></td>
        <td id="LC202" class="blob-line-code js-file-line">                <span class="c1">//material.SetColor(&quot;_RimColor&quot;, rimColor);</span></td>
      </tr>
      <tr>
        <td id="L203" class="blob-line-num js-line-number" data-line-number="203"></td>
        <td id="LC203" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L204" class="blob-line-num js-line-number" data-line-number="204"></td>
        <td id="LC204" class="blob-line-code js-file-line">                <span class="c1">//}</span></td>
      </tr>
      <tr>
        <td id="L205" class="blob-line-num js-line-number" data-line-number="205"></td>
        <td id="LC205" class="blob-line-code js-file-line">                <span class="c1">//catch (Exception e)</span></td>
      </tr>
      <tr>
        <td id="L206" class="blob-line-num js-line-number" data-line-number="206"></td>
        <td id="LC206" class="blob-line-code js-file-line">                <span class="c1">//{</span></td>
      </tr>
      <tr>
        <td id="L207" class="blob-line-num js-line-number" data-line-number="207"></td>
        <td id="LC207" class="blob-line-code js-file-line">                <span class="c1">//    print(&quot;RP: ReplaceShader exception: &quot; + e.ToString() + &quot;: &quot; + e.Message);</span></td>
      </tr>
      <tr>
        <td id="L208" class="blob-line-num js-line-number" data-line-number="208"></td>
        <td id="LC208" class="blob-line-code js-file-line">                <span class="c1">//}</span></td>
      </tr>
      <tr>
        <td id="L209" class="blob-line-num js-line-number" data-line-number="209"></td>
        <td id="LC209" class="blob-line-code js-file-line">                <span class="c1">// Add texture scale support</span></td>
      </tr>
      <tr>
        <td id="L210" class="blob-line-num js-line-number" data-line-number="210"></td>
        <td id="LC210" class="blob-line-code js-file-line">                <span class="n">material</span><span class="p">.</span><span class="n">mainTextureScale</span> <span class="p">=</span> <span class="n">pRenderer</span><span class="p">.</span><span class="n">material</span><span class="p">.</span><span class="n">mainTextureScale</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L211" class="blob-line-num js-line-number" data-line-number="211"></td>
        <td id="LC211" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L212" class="blob-line-num js-line-number" data-line-number="212"></td>
        <td id="LC212" class="blob-line-code js-file-line">                <span class="n">pRenderer</span><span class="p">.</span><span class="n">material</span> <span class="p">=</span> <span class="n">material</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L213" class="blob-line-num js-line-number" data-line-number="213"></td>
        <td id="LC213" class="blob-line-code js-file-line">                <span class="n">ReflectiveScript</span> <span class="n">reflectiveScript</span> <span class="p">=</span> <span class="k">this</span><span class="p">.</span><span class="n">part</span><span class="p">.</span><span class="n">gameObject</span><span class="p">.</span><span class="n">AddComponent</span><span class="p">&lt;</span><span class="n">ReflectiveScript</span><span class="p">&gt;();</span></td>
      </tr>
      <tr>
        <td id="L214" class="blob-line-num js-line-number" data-line-number="214"></td>
        <td id="LC214" class="blob-line-code js-file-line">                <span class="n">reflectiveScript</span><span class="p">.</span><span class="n">MatRenderer</span> <span class="p">=</span> <span class="n">pRenderer</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L215" class="blob-line-num js-line-number" data-line-number="215"></td>
        <td id="LC215" class="blob-line-code js-file-line">                <span class="n">reflectiveScript</span><span class="p">.</span><span class="n">CubemapSize</span> <span class="p">=</span> <span class="k">this</span><span class="p">.</span><span class="n">CubeMapSize</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L216" class="blob-line-num js-line-number" data-line-number="216"></td>
        <td id="LC216" class="blob-line-code js-file-line">                <span class="n">reflectiveScript</span><span class="p">.</span><span class="n">FarClipPlane</span> <span class="p">=</span> <span class="k">this</span><span class="p">.</span><span class="n">FarClipPlane</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L217" class="blob-line-num js-line-number" data-line-number="217"></td>
        <td id="LC217" class="blob-line-code js-file-line">                <span class="n">reflectiveScript</span><span class="p">.</span><span class="n">NearClipPlane</span> <span class="p">=</span> <span class="k">this</span><span class="p">.</span><span class="n">NearClipPlane</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L218" class="blob-line-num js-line-number" data-line-number="218"></td>
        <td id="LC218" class="blob-line-code js-file-line">                <span class="n">reflectiveScript</span><span class="p">.</span><span class="n">OneFacePerFrame</span> <span class="p">=</span> <span class="k">this</span><span class="p">.</span><span class="n">OneFacePerFrame</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L219" class="blob-line-num js-line-number" data-line-number="219"></td>
        <td id="LC219" class="blob-line-code js-file-line">                <span class="n">reflectiveScript</span><span class="p">.</span><span class="n">realTimeReflection</span> <span class="p">=</span> <span class="k">this</span><span class="p">.</span><span class="n">realTimeReflection</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L220" class="blob-line-num js-line-number" data-line-number="220"></td>
        <td id="LC220" class="blob-line-code js-file-line">                <span class="n">reflectiveScript</span><span class="p">.</span><span class="n">updateRate</span> <span class="p">=</span> <span class="k">this</span><span class="p">.</span><span class="n">updateRate</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L221" class="blob-line-num js-line-number" data-line-number="221"></td>
        <td id="LC221" class="blob-line-code js-file-line">                <span class="n">reflectiveScript</span><span class="p">.</span><span class="n">dirty</span> <span class="p">=</span> <span class="m">7</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L222" class="blob-line-num js-line-number" data-line-number="222"></td>
        <td id="LC222" class="blob-line-code js-file-line">                <span class="k">this</span><span class="p">.</span><span class="n">reflectiveScript</span> <span class="p">=</span> <span class="n">reflectiveScript</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L223" class="blob-line-num js-line-number" data-line-number="223"></td>
        <td id="LC223" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">Log</span><span class="p">((</span><span class="kt">object</span><span class="p">)</span><span class="s">&quot;RP: Material, shader and texture updated.&quot;</span><span class="p">);</span></td>
      </tr>
      <tr>
        <td id="L224" class="blob-line-num js-line-number" data-line-number="224"></td>
        <td id="LC224" class="blob-line-code js-file-line">            <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L225" class="blob-line-num js-line-number" data-line-number="225"></td>
        <td id="LC225" class="blob-line-code js-file-line">            <span class="k">else</span></td>
      </tr>
      <tr>
        <td id="L226" class="blob-line-num js-line-number" data-line-number="226"></td>
        <td id="LC226" class="blob-line-code js-file-line">                <span class="n">Debug</span><span class="p">.</span><span class="n">LogError</span><span class="p">((</span><span class="kt">object</span><span class="p">)(</span><span class="s">&quot;RP: Unable to find a Renderer component on the part. Part: &quot;</span> <span class="p">+</span> <span class="k">this</span><span class="p">.</span><span class="n">part</span><span class="p">.</span><span class="n">partName</span><span class="p">));</span></td>
      </tr>
      <tr>
        <td id="L227" class="blob-line-num js-line-number" data-line-number="227"></td>
        <td id="LC227" class="blob-line-code js-file-line">        <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L228" class="blob-line-num js-line-number" data-line-number="228"></td>
        <td id="LC228" class="blob-line-code js-file-line">        <span class="k">public</span> <span class="k">void</span> <span class="nf">FixedUpdate</span><span class="p">()</span></td>
      </tr>
      <tr>
        <td id="L229" class="blob-line-num js-line-number" data-line-number="229"></td>
        <td id="LC229" class="blob-line-code js-file-line">        <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L230" class="blob-line-num js-line-number" data-line-number="230"></td>
        <td id="LC230" class="blob-line-code js-file-line">            <span class="n">scriptStatus</span> <span class="p">=</span> <span class="k">this</span><span class="p">.</span><span class="n">reflectiveScript</span><span class="p">.</span><span class="n">status</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L231" class="blob-line-num js-line-number" data-line-number="231"></td>
        <td id="LC231" class="blob-line-code js-file-line">            <span class="n">lastScene</span> <span class="p">=</span> <span class="k">this</span><span class="p">.</span><span class="n">reflectiveScript</span><span class="p">.</span><span class="n">lastScene</span><span class="p">;</span></td>
      </tr>
      <tr>
        <td id="L232" class="blob-line-num js-line-number" data-line-number="232"></td>
        <td id="LC232" class="blob-line-code js-file-line">        <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L233" class="blob-line-num js-line-number" data-line-number="233"></td>
        <td id="LC233" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L234" class="blob-line-num js-line-number" data-line-number="234"></td>
        <td id="LC234" class="blob-line-code js-file-line"><span class="c1">//        public override void OnUpdate()</span></td>
      </tr>
      <tr>
        <td id="L235" class="blob-line-num js-line-number" data-line-number="235"></td>
        <td id="LC235" class="blob-line-code js-file-line"><span class="c1">//        {</span></td>
      </tr>
      <tr>
        <td id="L236" class="blob-line-num js-line-number" data-line-number="236"></td>
        <td id="LC236" class="blob-line-code js-file-line"><span class="c1">//            base.OnUpdate();</span></td>
      </tr>
      <tr>
        <td id="L237" class="blob-line-num js-line-number" data-line-number="237"></td>
        <td id="LC237" class="blob-line-code js-file-line"><span class="c1">//            this.lastScene = this.reflectiveScript.lastScene;</span></td>
      </tr>
      <tr>
        <td id="L238" class="blob-line-num js-line-number" data-line-number="238"></td>
        <td id="LC238" class="blob-line-code js-file-line"><span class="c1">//            this.lastUpdate = this.reflectiveScript.lastUpdate;</span></td>
      </tr>
      <tr>
        <td id="L239" class="blob-line-num js-line-number" data-line-number="239"></td>
        <td id="LC239" class="blob-line-code js-file-line"><span class="c1">//            this.scriptStatus = this.reflectiveScript.status;</span></td>
      </tr>
      <tr>
        <td id="L240" class="blob-line-num js-line-number" data-line-number="240"></td>
        <td id="LC240" class="blob-line-code js-file-line"><span class="c1">//        }</span></td>
      </tr>
      <tr>
        <td id="L241" class="blob-line-num js-line-number" data-line-number="241"></td>
        <td id="LC241" class="blob-line-code js-file-line">    <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L242" class="blob-line-num js-line-number" data-line-number="242"></td>
        <td id="LC242" class="blob-line-code js-file-line"><span class="p">}</span></td>
      </tr>
</table>

  </div>

  </div>
</div>

<a href="#jump-to-line" rel="facebox[.linejump]" data-hotkey="l" style="display:none">Jump to Line</a>
<div id="jump-to-line" style="display:none">
  <form accept-charset="UTF-8" class="js-jump-to-line-form">
    <input class="linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" autofocus>
    <button type="submit" class="button">Go</button>
  </form>
</div>

        </div>

      </div><!-- /.repo-container -->
      <div class="modal-backdrop"></div>
    </div><!-- /.container -->
  </div><!-- /.site -->


    </div><!-- /.wrapper -->

      <div class="container">
  <div class="site-footer">
    <ul class="site-footer-links right">
      <li><a href="https://status.github.com/">Status</a></li>
      <li><a href="http://developer.github.com">API</a></li>
      <li><a href="http://training.github.com">Training</a></li>
      <li><a href="http://shop.github.com">Shop</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="/about">About</a></li>

    </ul>

    <a href="/" aria-label="Homepage">
      <span class="mega-octicon octicon-mark-github" title="GitHub"></span>
    </a>

    <ul class="site-footer-links">
      <li>&copy; 2014 <span title="0.11433s from github-fe124-cp1-prd.iad.github.net">GitHub</span>, Inc.</li>
        <li><a href="/site/terms">Terms</a></li>
        <li><a href="/site/privacy">Privacy</a></li>
        <li><a href="/security">Security</a></li>
        <li><a href="/contact">Contact</a></li>
    </ul>
  </div><!-- /.site-footer -->
</div><!-- /.container -->


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-suggester-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="fullscreen-contents js-fullscreen-contents js-suggester-field" placeholder=""></textarea>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped tooltipped-w" aria-label="Exit Zen Mode">
      <span class="mega-octicon octicon-screen-normal"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped tooltipped-w"
      aria-label="Switch themes">
      <span class="octicon octicon-color-mode"></span>
    </a>
  </div>
</div>



    <div id="ajax-error-message" class="flash flash-error">
      <span class="octicon octicon-alert"></span>
      <a href="#" class="octicon octicon-x close js-ajax-error-dismiss" aria-label="Dismiss error"></a>
      Something went wrong with that request. Please try again.
    </div>


      <script crossorigin="anonymous" src="https://assets-cdn.github.com/assets/frameworks-2b4202fc62ef88e1a007a9ed05df10607b189f42.js" type="text/javascript"></script>
      <script async="async" crossorigin="anonymous" src="https://assets-cdn.github.com/assets/github-dc8670e62bf9b0f16ce342f51205e9f6a8b6ee88.js" type="text/javascript"></script>
      
      
        <script async src="https://www.google-analytics.com/analytics.js"></script>
  </body>
</html>

