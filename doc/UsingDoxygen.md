# Documenting LArSoft code in doxygen ########################################## {#UsingDoxygen}

| Document name:  | UsingDoxygen                          |
| --------------- | ------------------------------------- |
| Type:           | Policy and recommendations            |
| Author:         | Gianluca Petrillo (petrillo@fnal.gov) |
| Created on:     | December 28, 2017                     |
| Version:        | 1.0                                   |


This document describes aspects of the documentation of LArSoft code from
sources.


## How to use this document ####################################################

The sections of this document can be read independently.

Note that the document was written with doxygen 1.8.13 as reference.

The format is [Markdown format], that you can convert it to something else with:
    
    pandoc -s -S --toc -o UsingDoxygen.html UsingDoxygen.md
    pandoc -s -S --toc -o UsingDoxygen.pdf UsingDoxygen.md
    
et cetera.
Note that this file is about doxygen, and it is also processed by `doxygen`.
This means that typing in the document complete doxygen commands (either with
`@` or with `\`) will trigger a doxygen action. For that reason, the commands
names here are printed _with a prefix `\@`_ (e.g. `\@defgroup`).


## Structured documentation ####################################################

The goal of structuring documentation is to have the main page and subpages of
[LArSoft doxygen] page grouping the documentation in a sensible and usable way.

There are two levels of documentation:
1. object documentation: pertaining a class, a namespace, a function
2. topic documentation: pertaining higher level topic or pattern, that utilises
   a combination of objects

For example, `proxy::Tracks` is a proxy object which has its own usage, while
the proxy concept and patterns are a vaster topic which includes, among others,
that `proxy::Tracks` object.

The intention is to provide the object documentation in the same source file as
the code itself (typically in the header files where the interfaces are
declared), and provide the overview documentation in separate documents.

Structuring these two levels in a consistent whole can be achieved with some
careful use of doxygen.
The document files are written in [Markdown format], which Doxygen can more or
less parse and render. Doxygen itself has three different levels of
documentation [Doxygen grouping][grouping]:
* grouping by `\@defgroup` family of commands, creating a _module_
* grouping by `\@page` family of commands, creating a _page_

The `\@defgroup` way defines a topic group into a "module".
All modules are listed in the main page under the "Modules" tab.
Groups can be nested, and their content can be contributed from different parts
of the code.

The `\@page` way defines a documentation "page".
All documentation pages are listed in the main page under the "Related Pages"
tab. Pages can contain subpages.

The approach we use is to use pages to have the documentation be driven by the
modules, which describe the higher level topics and which contain the
documentation of the specific code objects. The pages are used only for
extensive high level documentation that has the flavour of a self-sufficient
document, like the complete documentation of an example. These pages are
provided in a more strict Markdown format, so that they can be moved outside
doxygen.
This is a fairly vague guideline, which should not be enforced over readability.

Pages and modules are pretty distinct elements in doxygen.
With an example (`larexamples`!), we illustrate how they can be merged.
The idea is that each example is described in its own _page_, and this page
is connected to the documentation of all the code objects in the example, which
live in their _module_.
The outer element will be the module.
The examples are structured as follows:
    
    larexamples
     |-- Services
     |    |-- AtomicNumber
     |    `-- ShowerCalibrationGalore
     |-- Algorithms
     |    |-- RemoveIsolatedSpacePoints
     |    `-- TotallyCheatTracks
     `-- AnalysisExample
    
We will pursue a similar structure in terms of Doxygen modules.


### Documentation of an example                                              ###

First, we focus on a single example: `TotallyCheatTracks`.

We already have a `README.md` file describing the example in detail.
With no special care, that file will show among the "Related pages" as "README".
First, we make sure the title of the document is in the very first line, and
we also add a label to identify it in doxygen:
    
    #  An algorithm producing a new data product: `TotallyCheatTrackingAlg`  {#TotallyCheatTracks_README}
    
The table (which used to be above the title) is moved just after the title.
With this change, a page now appears at the top level of the related pages, as
_An algorithm producing a new data product: `TotallyCheatTrackingAlg`_.
It is rendered in doxygen, but we don't guarantee on the correct rendering since
doxygen has its own interpretation of Markdown, and also of its own special
commands. Defining a label for it also makes this a doxygen documentation block,
feature that will come handy in a moment.

Next, we create a new documentation file, `TotallyCheatTracks.dox`. The `dox`
suffix is recognised and parsed by doxygen by default. This file will contain
doxygen commands within a C-style comment block. We use this file as the head of
documentation, which provides connections but almost no content.
For starts, we define a doxygen group for the example itself:
    
    \@defgroup TotallyCheatTracks TotallyCheatTracks
    
(remember that the `\` in `\@defgroup` is spurious and it's in this document
only for rendering needs). The first element is a doxygen identifier (with the
same name as the example, following its capitalisation despite doxygen
recommendations), and the second is a "title" associated with the group.
We also add a brief description of the group:
    
    \@brief Defines a new data product and produces it and its associations.
    
The title and brief description will appear in the table of doxygen modules.
Rendering this will show, in fact, the module "TotallyCheatTracks".
We then tell doxygen to include the content of the documentation element
associated to the `README.md` file directly into this module. The file
`TotallyCheatTracks.dox` now looks like:
    
    /**
    
    \@defgroup TotallyCheatTracks TotallyCheatTracks
    \@brief Defines a new data product and produces it and its associations.
    
    \@copydoc TotallyCheatTracks_README
    
     */
    
And blam! opening the doxygen module `TotallyCheatTracks` now renders the brief
description above and then the whole content of the `README.md` file (again,
with all the limits of doxygen markdown).

The doxygen module is still empty: no code is associated with it.
To fix that, a detailed tagging action has to be performed. We add the line
    
    \@ingroup TotallyCheatTracks
    
to each of the file documentation blocks, and then we wrap the relevant objects
in a documentation group like:
    
    namespace lar {
      namespace example {
        
        // BEGIN group TotallyCheatTracks --------------------------------------
        /// \@ingroup TotallyCheatTracks
        /// \@{
        
        // ...
        
        /// \@}
        // END group TotallyCheatTracks ----------------------------------------
        
      } // namespace example
    } // namespace lar
    
In this way everything that is defined in the block of code starting at
`namespace example` will be included in the doxygen group `TotallyCheatTracks`,
while the namespace `examples` itself will not be (in fact, it shouldn't be
since it contains also examples other than `TotallyCheatTracks`). The comment
lines with `BEGIN` and `END` are for readability only and have no special
meaning neither in doxygen nor in C++ (but some editors may use them to mark a
editing block).

It may be helpful to add a link to the example overview in some key classes that
may be "access points". For example, we can add:
    
    \@see \@ref TotallyCheatTracks "TotallyCheatTracks example overview"
    
to the documentation of `lar::example::TotallyCheatTracker` module and
`lar::example::TotallyCheatTrackingAlg` algorithm class.

After all of this, the module `TotallyCheatTracks` is rendered in doxygen with
* a brief description ("Defines a new data product and produces it and its
  associations") and a link to a more extensive description
* all the code objects in the group (at time of writing, 5 files, 3 objects and
  a free function)
* the detailed description, a rendered version of the `README.md` file.

While it is a good idea to instrument tests with doxygen documentation, we
currently skip the `test` directories from the rendering of the standard
LArSoft documentation. The "ingrouping" is still recommended in tests as well.


### Creating the documentation structure                                     ###

We have learned how to document a single example, with the result that the
example documentation appears at the top level of both the _Related pages_ and
_Modules_ tabs.
This section describes the creation of the final structure.

We want the `TotallyCheatTracks` group to be a subgroup of the algorithm example
documentation. Therefore, we create a head file in the `Algorithms` directory,
called `Algorithms.dox` (following the self-imposed convention of using the
directory name for the group name and the documentation head file name).
In it, we create, in a doxygen documentation block, a new group
`larexamples_Algorithms` with a brief description:
    
    \@defgroup larexamples_Algorithms Algorithms
    \@brief Examples of LArSoft algorithms and _art_ modules.
    
We follow with some high level documentation of algorithm guidelines and
whatever we want to put here. Since this is high-level information, there are
probably better places for it to live than with the source code, so links to web
pages are recommended.
Then we can add a line:
    
    \@ingroup larexamples_Algorithms
    
in each of the group definitions of the relevant algorithm example groups (e.g.
`TotallyCheatTracks`). Rendering the documentation will show that the algorithms
have become submodules of the `larexamples_Algorithms` module, while their pages
are still in the wild, at top level.
To pick them, we create a new placeholder page, and add to it the subpages
related to the subgroups:
    
    \@page larexamples_Algorithms_mainpage Algorithms
    
    Please refer to the full documentation in
    \@ref larexamples_Algorithms "algorithm example module".
    
    Contents
    ---------
    
    \@subpage TotallyCheatTracks_README
    
The page is called `larexamples_Algorithms_mainpage` and will appear as
`Algorithms` in the listing. Rendering it it will show that `Algorithms` now
contains subpages. For convenience, a reference to the doxygen module is spelled
out, too. Note that the inclusion of the pages is top-down, with each page
picking all its subpages, while the module composition is bottom-up, with each
group picking its parent group(s).

In the same way, `larexamples.dox` can be created to enclose the algorithm
example module and page, as well as the others at the same level.



## Recommendations for doxygen documentation ###################################


* in the `\@file` documentation line, spell the whole path of the file, up to
  the repository name (excluded). For example:
      
      \@file larcorealg/Geometry/GeometryCore.h
      
  instead of just `\@file GeometryCore.h`. The advantages are:
    * doxygen will not complain if two files happen to have the same name, as
      long as their relative path is different, and will handle the links
      correctly
    * in the rendered code documentation, the `include` lines will link to the
      header documentation
* consider the most likely access point objects (e.g. _art_ module or algorithm
  class) and add a reference to the doxygen overview module (group):
    
    \@see \@ref OverviewGroupName
    
* add a "module"/"service" keywork in the brief description of _art_ modules and
  services, to help identify them when in a class list


## Questions? ##################################################################

For discussions and proposals, please contact the LArSoft management at
larsoft-team@fnal.gov.



## Change log ##################################################################

Version 1.0: December 28, 2017 (petrillo@fnal.gov)
  original, unvetted version



[original Markdown format]:
  <https://daringfireball.net/projects/markdown/syntax> (Markdown)
[Markdown format]:
  <http://pandoc.org/MANUAL.html#pandocs-markdown> (pandoc flavour of Markdown)
[doxygen grouping]:
  <http://www.stack.nl/~dimitri/doxygen/manual/grouping.html>
[LArSoft doxygen]:
  <http://nusoft.fnal.gov/larsoft/doxsvn/html/index.html>
[LArSoft wiki]:
  <https://cdcvs.fnal.gov/redmine/projects/larsoft/wiki/Writing_LArSoft_algorithms>

