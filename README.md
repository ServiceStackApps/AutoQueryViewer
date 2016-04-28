# AutoQuery Viewer

AutoQuery Viewer is a native iPad App that provides an automatic UI for browsing, inspecting and querying any publicly accessible [ServiceStack AutoQuery Service](https://github.com/ServiceStack/ServiceStack/wiki/Auto-Query) directly from within an optimized iPad App. 

Together with [AutoQuery](https://github.com/ServiceStack/ServiceStack/wiki/Auto-Query) you can effortlessly deploy a web services endpoint to enable querying over existing RDBMS tables and then connect to it from AutoQuery Viewer to provide an instant, customizable native UI for querying your systems data from an iPad.

## [Download Now!](https://itunes.apple.com/us/app/autoquery-viewer/id968625288?ls=1&mt=8)

It's also a free download and comes pre-registered with AutoQuery Services from different ServiceStack [Live Demos](https://github.com/ServiceStackApps/LiveDemos) to illustrate the query functionality and the level of customizability available:

[![AutoQuery Viewer on AppStore](https://raw.githubusercontent.com/ServiceStack/Assets/master/img/wikis/autoquery/autoqueryviewer-appstore.png)](https://itunes.apple.com/us/app/autoquery-viewer/id968625288?ls=1&mt=8)

## About

AutoQuery Viewer was inspired by the [TechStacks Cocoa OSX Desktop App](https://github.com/ServiceStackApps/TechStacksDesktopApp) to provide a native UI around AutoQuery Services, but instead of being coupled to a specific Service its goal is to instead provide a generic and customizable UI that works with any AutoQuery Service.

Like [other iOS Apps before it](https://github.com/ServiceStackApps/TechStacksApp), AutoQuery Viewer takes advantage of [ServiceStack's support for Swift](https://github.com/ServiceStack/ServiceStack/wiki/Swift-Add-ServiceStack-Reference) to simplify consuming ServiceStack .NET Web Services from Swift. This repository maintains the source code of the AutoQuery Viewer App which you can browse for a closer look.

## Customizable Native UI

Unlike many native UI's, AutoQuery Viewer doesn't know anything about existing AutoQuery Services before loading them. In this way it works similar to viewing a Website where all the information about which AutoQuery Services, Columns, Filters, Images and Themes to display are all configured and downloaded on the fly from the remote ServiceStack instance where it's all configured. AutoQuery Services are also highly themeable as seen in the Screenshots of the Live AutoQuery Services available below:

## Screenshots

> The Home page showing a list of publicly available AutoQuery Services to choose from:

![AutoQuery Viewer Home](https://raw.githubusercontent.com/ServiceStack/Assets/master/img/wikis/autoquery/autoqueryviewer-home.png)

The home page also allows connecting to ad hoc AutoQuery Services by just providing the url of the remote ServiceStack instance in the textbox below. Later we'll go through how easy it is to publish your AutoQuery service to this list so its accessible by everyone.

### TechStacks AutoQuery Home

![TechStacks Home](https://raw.githubusercontent.com/ServiceStack/Assets/master/img/wikis/autoquery/techstacks-home.png)

Clicking on an existing listing (or viewing an ad hoc url) will take you to the home page of that particular ServiceStack instance which displays the list of the different AutoQuery services that are available to view. 

The different home pages of each instance shows the amount of customization available to be able to tailor and personalize the UI around your AutoQuery Services:

### GitHub AutoQuery Home

![GitHub AutoQuery Home](https://raw.githubusercontent.com/ServiceStack/Assets/master/img/wikis/autoquery/github-home.png)

### StackApis AutoQuery Home

![StackApis AutoQuery Home](https://raw.githubusercontent.com/ServiceStack/Assets/master/img/wikis/autoquery/stackapis-home.png)

[StackApis](https://github.com/ServiceStackApps/StackApis) is a a good example of the functionality AutoQuery enables out of the box where the entire [StackApis Live Demo](http://stackapis.servicestack.net) is built around the single AutoQuery Service below:

```csharp
[Route("/questions")]
public class StackOverflowQuery : QueryBase<Question>
{
    public int? ScoreGreaterThan { get; set; }
}
```

AutoQuery Viewer adds additional value by providing an instant UI to query this Service from a native iPad App. It's interesting to compare the tailored Ajax UI on [stackapis.servicestack.net](http://stackapis.servicestack.net) with AutoQuery Viewer's generic UI.

## Browsing and Querying

From each home page you can drill down and select the AutoQuery service you're interested in which will display the default results for that query, e.g. here are the results when clicking on **Find Technologies** in TechStacks:

![TechStack Technologies Results](https://raw.githubusercontent.com/ServiceStack/Assets/master/img/wikis/autoquery/techstacks-technologies-results.png)

Each Service can choose what results to show by default which provides the user an example of the data the service returns.

### Filtering Columns

The results page has 3 fields which can be used to customize the query. The first field lets the user choose which **field** they want to filter. Clicking on any field will bring up an iOS Picker populated with all the available columns that you can choose from by Swiping up/down on the UI Picker control:

![TechStacks Column Picker](https://raw.githubusercontent.com/ServiceStack/Assets/master/img/wikis/autoquery/techstacks-columns.png)

After selecting the column to filter, the Query Type Picker will pop up with the different types of query options to filter the results by:

![TechStacks Query Type Picker](https://raw.githubusercontent.com/ServiceStack/Assets/master/img/wikis/autoquery/techstacks-filters.png)

By default it shows a list of common query filters, although even the different types of filters is configurable.

The last field is a free text search box to capture the search term, when all fields are populated hitting **Search** will execute the query and display the results.

## View CSV

A nice side-effect of [AutoQuery](https://github.com/ServiceStack/ServiceStack/wiki/Auto-Query) just being regular ServiceStack Services is that they have full access to all of ServiceStack's supported Content Types. A particular stand-out [for returning tabular datasets is the CSV format](https://github.com/ServiceStack/ServiceStack/wiki/Auto-Query#mime-types-and-content-negotiation) which enables viewing AutoQuery results in other Applications despite the strong isolation in iOS limiting integration between Apps.

### Open in Safari

In addition to browsing search results in the results grid, users can also click on the **view csv** link to get iOS to "open" a `.csv` snapshot of the results which by default opens the results in Safari:

![AutoQuery results in Safari](https://raw.githubusercontent.com/ServiceStack/Assets/master/img/wikis/autoquery/techstacks-safari.png)

One difference of viewing the results in Safari is that it shows the full contents of each field whereas AutoQuery Viewer clips long fields to simplify browsing/navigation.

### Import into iOS Numbers

A more interesting feature of viewing `.csv` results in Safari is that it lets you open the results in other Applications. One stand-out is being able to import the results in Apple's [iOS Numbers App](https://www.apple.com/ios/numbers/) which gives you the functionality of using a full-featured Spreadsheet to be able to analyze the dataset further, e.g. applying custom formula's or creating charts from the data:

![AutoQuery results in Numbers](https://raw.githubusercontent.com/ServiceStack/Assets/master/img/wikis/autoquery/techstacks-numbers.png)

## Customizing AutoQuery Viewer

By default no additional effort is required to view AutoQuery Services, you can simply provide the url to a remote ServiceStack instance and AutoQuery Viewer will display the different AutoQuery Services available.

However all examples above take advantage of the customization options available to provide a richer UX and more personalized UI. 

The primary configuration options are available on the `AutoQueryViewerConfig` typed property when registering the `AutoQueryFeature` feature. To better illustrate what each of the options does we'll include the different AutoQueryFeature configurations of each of the above examples:

### [TechStacks Configuration](https://github.com/ServiceStackApps/TechStacks/blob/41fd7ab78aab58174deaa5353761c7033605f783/src/TechStacks/TechStacks/AppHost.cs#L137)

```csharp
Plugins.Add(new AutoQueryMetadataFeature
{
    MaxLimit = 200,
    AutoQueryViewerConfig =
    {
        ServiceDescription = "Discover what tech were used to create popular  Apps",
        ServiceIconUrl = "/img/app/logo-76.png",
        BackgroundColor = "#0095F5",            
        TextColor = "#fff",
        LinkColor = "#ffff8d",
        BrandImageUrl = "/img/app/brand.png",
        BrandUrl = "http://techstacks.io",
        BackgroundImageUrl = "/img/app/bg.png",
        IsPublic = true,
    }
});
```

### [GitHubAutoQuery Configuration](https://github.com/ServiceStackApps/GitHubAutoQuery/blob/4407b2a0f23a4708188454c36a43682bf5ab2928/src/GitHubAutoQuery/GitHubAutoQuery/AppHost.cs#L117)

```csharp
Plugins.Add(new AutoQueryMetadataFeature
{
    LoadFromAssemblies = { typeof(QueryRepos).Assembly },
    MaxLimit = 200,
    AutoQueryViewerConfig =
    {
        ServiceDescription = "Browse ServiceStack on GitHub",
        ServiceIconUrl = "/img/app/autoquery-75.png",
        BackgroundColor = "#253D48",
        TextColor = "#fff",
        LinkColor = "#ffff8d",
        BrandImageUrl = "/img/app/brand-inverted.png",
        BrandUrl = "https://github.com/ServiceStack/ServiceStack/",
        BackgroundImageUrl = "/img/app/bg.png",
        IsPublic = true,
    }
});
```

### [StackApis Configuration](https://github.com/ServiceStackApps/StackApis/blob/7c6ca0aa985eac1e6411486f1ea7d1d91f96c877/src/StackApis/AppHost.cs#L35)

```csharp
Plugins.Add(new AutoQueryMetadataFeature
{
    MaxLimit = 100,
    AutoQueryViewerConfig =
    {
        ServiceDescription = "Search for ServiceStack Questions on StackOverflow",
        ServiceIconUrl = "/Content/app/logo-76.png",
        BackgroundColor = "#fc9a24",
        TextColor = "#fff",
        LinkColor = "#ffff8d",
        BrandImageUrl = "/Content/app/brand.png",
        BrandUrl = "http://stackapis.servicestack.net/",
        BackgroundImageUrl = "/Content/app/bg.png",
        IsPublic = true,
    }
});
```

### AutoQueryViewerConfig

AutoQueryViewerConfig holds the global configuration AutoQuery Viewer uses to control the look and feel when navigating and querying your Services:

<table>
<tr>
  <td>ServiceBaseUrl</td>
  <td>The BaseUrl of the ServiceStack instance (inferred)</td>
</tr>
<tr>
  <td>ServiceName</td>
  <td>Name of the ServiceStack Instance (inferred)</td>
</tr>
<tr>
  <td>ServiceDescription</td>
  <td>Textual description of the AutoQuery Services (shown in Home Services list)</td>
</tr>
<tr>
  <td>ServiceIconUrl</td>
  <td>Icon for this ServiceStack Instance (shown in Home Services list)</td>
</tr>
<tr>
  <td>IsPublic</td>
  <td>Whether to publish this Service to the public Services registry</td>
</tr>
<tr>
  <td>OnlyShowAnnotatedServices</td>
  <td>Only show AutoQuery Services attributed with `[AutoQueryViewer]`</td>
</tr>
<tr>
  <td>ImplicitConventions</td>
  <td>List of different Search Filters available</td>
</tr>
<tr>
  <td>DefaultSearchField</td>
  <td>The Column which should be selected by default</td>
</tr>
<tr>
  <td>DefaultSearchType</td>
  <td>The Query Type filter which should be selected by default</td>
</tr>
<tr>
  <td>DefaultSearchText</td>
  <td>The search text which should be populated by default</td>
</tr>
<tr>
  <td>BrandUrl</td>
  <td>Link to your website users can click to find out more about you</td>
</tr>
<tr>
  <td>BrandImageUrl</td>
  <td>A custom logo or image that users can click on to visit your site</td>
</tr>
<tr>
  <td>TextColor</td>
  <td>The default color of text</td>
</tr>
<tr>
  <td>LinkColor</td>
  <td>The default color of links</td>
</tr>
<tr>
  <td>BackgroundColor</td>
  <td>The default background color of each screen</td>
</tr>
<tr>
  <td>BackgroundImageUrl</td>
  <td>The default background image of each screen anchored to the bottom left</td>
</tr>
<tr>
  <td>IconUrl</td>
  <td>The default icon for each of your AutoQuery Services</td>
</tr>
</table>

### ImplicitConventions

The `ImplicitConventions` collection lists which Search filters your AutoQuery Services support, by default its populated with the common options below:

```csharp
ImplicitConventions = new List<Property>
{
    new Property { Name = "=", Value = "%"},
    new Property { Name = ">=", Value = ">%"},
    new Property { Name = ">", Value = "%>"},
    new Property { Name = "<=", Value = "%<"},
    new Property { Name = "<", Value = "<%"},
    new Property { Name = "In", Value = "%In"},
    new Property { Name = "Between", Value = "%Between"},
    new Property { Name = "Starts With", Value = "%StartsWith"},
    new Property { Name = "Contains", Value = "%Contains"},
    new Property { Name = "Ends With", Value = "%EndsWith"},
}
```

### IsPublic

The `IsPublic` option is what you can use to have your AutoQuery Service published in the public registry so it's available for anyone to query. If this is set to `true` then once you **connect** to your Services BaseUrl, AutoQuery Viewer automatically registers your Service so its visible for others to browse.

### Overridable Per-Service Configuration

These configuration options hold the default values for each of your AutoQuery Services, they can be further customized on a per-service basis by decorating your AutoQuery Request DTO's with the `[AutoQueryViewer]` and `[AutoQueryViewerField]` attributes.

To illustrate what this looks like, we'll include the AutoQuery definition of each of the available Services below:

### [TechStacks AutoQuery Reqeust DTOs](https://github.com/ServiceStackApps/TechStacks/blob/2ff11fc8e2f187a108f0e8000dac5c17282d130f/src/TechStacks/TechStacks.ServiceModel/Technologies.cs#L14)

```csharp
[Query(QueryTerm.Or)]
[Route("/technology/search")]
[AutoQueryViewer(
    Title = "Find Technologies", Description = "Explore different Technologies", 
    IconUrl = "/img/app/tech-white-75.png",
    DefaultSearchField = "Tier", DefaultSearchType = "=", DefaultSearchText = "Data")]
public class FindTechnologies : QueryBase<Technology>
{
    public bool Reload { get; set; }
}

[Query(QueryTerm.Or)]
[Route("/techstacks/search")]
[AutoQueryViewer(
    Title = "Find Technology Stacks", Description = "Explore different Technology Stacks", 
    IconUrl = "/img/app/stacks-white-75.png",
    DefaultSearchField = "Description", DefaultSearchType = "Contains", DefaultSearchText = "ServiceStack")]
public class FindTechStacks : QueryBase<TechnologyStack>
{
    public bool Reload { get; set; }
}
```

### [GitHubAutoQuery Request DTOs](https://github.com/ServiceStackApps/GitHubAutoQuery/blob/master/src/GitHubAutoQuery/GitHubAutoQuery.ServiceModel/GitHubAutoQueries.cs)

```csharp
[Route("/repos")]
[AutoQueryViewer(Title = "ServiceStack Repositories", 
    Description = "Browse list of different ServiceStack repositories",
    DefaultSearchField = "Language", DefaultSearchType = "=", DefaultSearchText = "C#",
    IconUrl = "/img/app/repos-inverted-75.png")]
public class QueryRepos : QueryBase<GithubRepo> {}

[Route("/commits")]
[AutoQueryViewer(Title = "ServiceStack Commits", Description = "Browse latest 1000 commits",
    DefaultSearchField = "Message", DefaultSearchType = "Contains", DefaultSearchText = "AutoQuery",        
    IconUrl = "/img/app/commits-inverted-75.png")]
public class QueryRepoCommits : QueryBase<GithubCommit> { }

[Route("/contents")]
[AutoQueryViewer(Title = "ServiceStack Files", 
    Description = "Browse ServiceStack top-level files and folders",
    DefaultSearchField = "Type", DefaultSearchType = "=", DefaultSearchText = "file",
    IconUrl = "/img/app/contents-inverted-75.png")]
public class QueryRepoContent : QueryBase<GithubContent> { }

[Route("/contributors")]
[AutoQueryViewer(Title = "ServiceStack Contributors", Description = "Browse ServiceStack Contributors",
    DefaultSearchField = "Contributions", DefaultSearchType = ">=", DefaultSearchText = "5",
    IconUrl = "/img/app/contributors-inverted-75.png")]
public class QueryRepoContributors : QueryBase<GithubContributor> { }

[Route("/subscribers")]
[AutoQueryViewer(Title = "ServiceStack Subscribers", Description = "Browse ServiceStack Subscribers",
    DefaultSearchField = "Type", DefaultSearchType = "=", DefaultSearchText = "User",
    IconUrl = "/img/app/subscribers-inverted-75.png")]
public class QueryRepoSubscribers : QueryBase<GithubSubscriber> { }

[Route("/comments")]
[AutoQueryViewer(Title = "ServiceStack Comments", Description = "Browse ServiceStack Subscribers",
    //DefaultSearchField = "Id", DefaultSearchType = ">", DefaultSearchText = "0",
    IconUrl = "/img/app/comments-inverted-75.png")]
public class QueryRepoComments : QueryBase<GithubComment> { }

[Route("/releases")]
[AutoQueryViewer(Title = "ServiceStack Releases", Description = "Browse ServiceStack Releases",
    DefaultSearchField = "Name", DefaultSearchType = "Starts With", DefaultSearchText = "v4",
    IconUrl = "/img/app/releases-inverted-75.png")]
public class QueryRepoReleases : QueryBase<GithubRelease> { }
```

### [StakApi AutoQuery Request DTO](https://github.com/ServiceStackApps/StackApis/blob/master/src/StackApis.ServiceModel/StackOverflowQuery.cs)

```csharp
[Route("/questions")]
[AutoQueryViewer(
    Title = "Explore StackOverflow Questions", 
    Description = "Find ServiceStack Questions on StackOverflow", 
    IconUrl = "/Content/app/stacks-white-75.png",
    DefaultSearchField = "Title", DefaultSearchType = "Contains", DefaultSearchText = "ServiceStack")]
public class StackOverflowQuery : QueryBase<Question>
{
    public int? ScoreGreaterThan { get; set; }
}
```

# Feedback Welcome!

We hope you find AutoQuery Viewer useful for exploring and querying your own AutoQuery Services and would love to hear any feedback on new features and improvements we can add to make AutoQuery Viewer even better! 

Please leave any suggestions on [ServiceStack's UserVoice](http://servicestack.uservoice.com/forums/176786-feature-requests).


