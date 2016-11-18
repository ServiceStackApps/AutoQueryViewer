/* Options:
Date: 2015-09-30 02:59:35
SwiftVersion: 2.0
Version: 4.046
BaseUrl: http://autoqueryviewer.servicestack.net

//BaseClass:
//AddModelExtensions: True
//AddServiceStackTypes: True
//IncludeTypes:
//ExcludeTypes:
//ExcludeGenericBaseTypes: True
//AddResponseStatus: False
//AddImplicitVersion:
//InitializeCollections: True
//DefaultImports: Foundation
*/

import Foundation;

// @Route("/ping")
open class Ping
{
    required public init(){}
}

// @Route("/services")
open class GetAutoQueryServices : IReturn
{
    public typealias Return = GetAutoQueryServicesResponse
    
    required public init(){}
    open var reload:Bool?
}

// @Route("/services/register")
open class RegisterAutoQueryService : IReturn
{
    public typealias Return = RegisterAutoQueryServiceResponse
    
    required public init(){}
    open var baseUrl:String?
}

open class Dummy
{
    required public init(){}
    open var autoQueryMetadata:AutoQueryMetadata?
    open var autoQueryMetadataResponse:AutoQueryMetadataResponse?
}

// @Route("/auth")
// @Route("/auth/{provider}")
// @Route("/authenticate")
// @Route("/authenticate/{provider}")
// @DataContract
open class Authenticate : IReturn
{
    public typealias Return = AuthenticateResponse
    
    required public init(){}
    // @DataMember(Order=1)
    open var provider:String?
    
    // @DataMember(Order=2)
    open var state:String?
    
    // @DataMember(Order=3)
    open var oauth_token:String?
    
    // @DataMember(Order=4)
    open var oauth_verifier:String?
    
    // @DataMember(Order=5)
    open var userName:String?
    
    // @DataMember(Order=6)
    open var password:String?
    
    // @DataMember(Order=7)
    open var rememberMe:Bool?
    
    // @DataMember(Order=8)
    open var `continue`:String?
    
    // @DataMember(Order=9)
    open var nonce:String?
    
    // @DataMember(Order=10)
    open var uri:String?
    
    // @DataMember(Order=11)
    open var response:String?
    
    // @DataMember(Order=12)
    open var qop:String?
    
    // @DataMember(Order=13)
    open var nc:String?
    
    // @DataMember(Order=14)
    open var cnonce:String?
    
    // @DataMember(Order=15)
    open var meta:[String:String] = [:]
}

// @Route("/assignroles")
// @DataContract
open class AssignRoles : IReturn
{
    public typealias Return = AssignRolesResponse
    
    required public init(){}
    // @DataMember(Order=1)
    open var userName:String?
    
    // @DataMember(Order=2)
    open var permissions:[String] = []
    
    // @DataMember(Order=3)
    open var roles:[String] = []
}

// @Route("/unassignroles")
// @DataContract
open class UnAssignRoles : IReturn
{
    public typealias Return = UnAssignRolesResponse
    
    required public init(){}
    // @DataMember(Order=1)
    open var userName:String?
    
    // @DataMember(Order=2)
    open var permissions:[String] = []
    
    // @DataMember(Order=3)
    open var roles:[String] = []
}

open class GetAutoQueryServicesResponse
{
    required public init(){}
    open var results:[AutoQueryService] = []
    open var responseStatus:ResponseStatus?
}

open class RegisterAutoQueryServiceResponse
{
    required public init(){}
    open var result:AutoQueryService?
    open var responseStatus:ResponseStatus?
}

// @DataContract
open class AuthenticateResponse
{
    required public init(){}
    // @DataMember(Order=1)
    open var userId:String?
    
    // @DataMember(Order=2)
    open var sessionId:String?
    
    // @DataMember(Order=3)
    open var userName:String?
    
    // @DataMember(Order=4)
    open var displayName:String?
    
    // @DataMember(Order=5)
    open var referrerUrl:String?
    
    // @DataMember(Order=6)
    open var responseStatus:ResponseStatus?
    
    // @DataMember(Order=7)
    open var meta:[String:String] = [:]
}

// @DataContract
open class AssignRolesResponse
{
    required public init(){}
    // @DataMember(Order=1)
    open var allRoles:[String] = []
    
    // @DataMember(Order=2)
    open var allPermissions:[String] = []
    
    // @DataMember(Order=3)
    open var responseStatus:ResponseStatus?
}

// @DataContract
open class UnAssignRolesResponse
{
    required public init(){}
    // @DataMember(Order=1)
    open var allRoles:[String] = []
    
    // @DataMember(Order=2)
    open var allPermissions:[String] = []
    
    // @DataMember(Order=3)
    open var responseStatus:ResponseStatus?
}

open class AutoQueryService
{
    required public init(){}
    open var id:Int?
    open var serviceBaseUrl:String?
    open var serviceName:String?
    open var serviceDescription:String?
    open var serviceIconUrl:String?
    open var isPublic:Bool?
    open var onlyShowAnnotatedServices:Bool?
    open var implicitConventions:[Property] = []
    open var defaultSearchField:String?
    open var defaultSearchType:String?
    open var defaultSearchText:String?
    open var brandUrl:String?
    open var brandImageUrl:String?
    open var textColor:String?
    open var linkColor:String?
    open var backgroundColor:String?
    open var backgroundImageUrl:String?
    open var iconUrl:String?
    open var ownerId:String?
    open var created:Date?
    open var createdBy:String?
    open var lastModified:Date?
    open var lastModifiedBy:String?
}

// @Route("/autoquery/metadata")
open class AutoQueryMetadata : IReturn
{
    public typealias Return = AutoQueryMetadataResponse

    required public init(){}
}

open class AutoQueryMetadataResponse
{
    required public init(){}
    open var config:AutoQueryViewerConfig?
    open var operations:[AutoQueryOperation] = []
    open var types:[MetadataType] = []
    open var responseStatus:ResponseStatus?
}

// @DataContract
open class Property
{
    required public init(){}
    // @DataMember
    open var name:String?
    
    // @DataMember
    open var value:String?
}

open class AutoQueryViewerConfig
{
    required public init(){}
    open var serviceBaseUrl:String?
    open var serviceName:String?
    open var serviceDescription:String?
    open var serviceIconUrl:String?
    open var isPublic:Bool?
    open var onlyShowAnnotatedServices:Bool?
    open var implicitConventions:[Property] = []
    open var defaultSearchField:String?
    open var defaultSearchType:String?
    open var defaultSearchText:String?
    open var brandUrl:String?
    open var brandImageUrl:String?
    open var textColor:String?
    open var linkColor:String?
    open var backgroundColor:String?
    open var backgroundImageUrl:String?
    open var iconUrl:String?
}

open class AutoQueryOperation
{
    required public init(){}
    open var request:String?
    open var from:String?
    open var to:String?
}

open class MetadataType
{
    required public init(){}
    open var name:String?
    open var namespace:String?
    open var genericArgs:[String] = []
    open var inherits:MetadataTypeName?
    open var implements:[MetadataTypeName] = []
    open var displayType:String?
    open var Description:String?
    open var returnVoidMarker:Bool?
    open var isNested:Bool?
    open var isEnum:Bool?
    open var isInterface:Bool?
    open var isAbstract:Bool?
    open var returnMarkerTypeName:MetadataTypeName?
    open var routes:[MetadataRoute] = []
    open var dataContract:MetadataDataContract?
    open var properties:[MetadataPropertyType] = []
    open var attributes:[MetadataAttribute] = []
    open var innerTypes:[MetadataTypeName] = []
    open var enumNames:[String] = []
    open var enumValues:[String] = []
}

open class MetadataTypeName
{
    required public init(){}
    open var name:String?
    open var namespace:String?
    open var genericArgs:[String] = []
}

open class MetadataRoute
{
    required public init(){}
    open var path:String?
    open var verbs:String?
    open var notes:String?
    open var summary:String?
}

open class MetadataDataContract
{
    required public init(){}
    open var name:String?
    open var namespace:String?
}

open class MetadataPropertyType
{
    required public init(){}
    open var name:String?
    open var type:String?
    open var isValueType:Bool?
    open var typeNamespace:String?
    open var genericArgs:[String] = []
    open var value:String?
    open var Description:String?
    open var dataMember:MetadataDataMember?
    open var readOnly:Bool?
    open var paramType:String?
    open var displayType:String?
    open var isRequired:Bool?
    open var allowableValues:[String] = []
    open var allowableMin:Int?
    open var allowableMax:Int?
    open var attributes:[MetadataAttribute] = []
}

open class MetadataAttribute
{
    required public init(){}
    open var name:String?
    open var constructorArgs:[MetadataPropertyType] = []
    open var args:[MetadataPropertyType] = []
}

open class MetadataDataMember
{
    required public init(){}
    open var name:String?
    open var order:Int?
    open var isRequired:Bool?
    open var emitDefaultValue:Bool?
}


extension Ping : JsonSerializable
{
    public static var typeName:String { return "Ping" }
    public static var metadata = Metadata.create([
        ])
}

extension GetAutoQueryServices : JsonSerializable
{
    public static var typeName:String { return "GetAutoQueryServices" }
    public static var metadata = Metadata.create([
        Type<GetAutoQueryServices>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
        ])
}

extension RegisterAutoQueryService : JsonSerializable
{
    public static var typeName:String { return "RegisterAutoQueryService" }
    public static var metadata = Metadata.create([
        Type<RegisterAutoQueryService>.optionalProperty("baseUrl", get: { $0.baseUrl }, set: { $0.baseUrl = $1 }),
        ])
}

extension Dummy : JsonSerializable
{
    public static var typeName:String { return "Dummy" }
    public static var metadata = Metadata.create([
        Type<Dummy>.optionalObjectProperty("autoQueryMetadata", get: { $0.autoQueryMetadata }, set: { $0.autoQueryMetadata = $1 }),
        Type<Dummy>.optionalObjectProperty("autoQueryMetadataResponse", get: { $0.autoQueryMetadataResponse }, set: { $0.autoQueryMetadataResponse = $1 }),
        ])
}

extension Authenticate : JsonSerializable
{
    public static var typeName:String { return "Authenticate" }
    public static var metadata = Metadata.create([
        Type<Authenticate>.optionalProperty("provider", get: { $0.provider }, set: { $0.provider = $1 }),
        Type<Authenticate>.optionalProperty("state", get: { $0.state }, set: { $0.state = $1 }),
        Type<Authenticate>.optionalProperty("oauth_token", get: { $0.oauth_token }, set: { $0.oauth_token = $1 }),
        Type<Authenticate>.optionalProperty("oauth_verifier", get: { $0.oauth_verifier }, set: { $0.oauth_verifier = $1 }),
        Type<Authenticate>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        Type<Authenticate>.optionalProperty("password", get: { $0.password }, set: { $0.password = $1 }),
        Type<Authenticate>.optionalProperty("rememberMe", get: { $0.rememberMe }, set: { $0.rememberMe = $1 }),
        Type<Authenticate>.optionalProperty("`continue`", get: { $0.`continue` }, set: { $0.`continue` = $1 }),
        Type<Authenticate>.optionalProperty("nonce", get: { $0.nonce }, set: { $0.nonce = $1 }),
        Type<Authenticate>.optionalProperty("uri", get: { $0.uri }, set: { $0.uri = $1 }),
        Type<Authenticate>.optionalProperty("response", get: { $0.response }, set: { $0.response = $1 }),
        Type<Authenticate>.optionalProperty("qop", get: { $0.qop }, set: { $0.qop = $1 }),
        Type<Authenticate>.optionalProperty("nc", get: { $0.nc }, set: { $0.nc = $1 }),
        Type<Authenticate>.optionalProperty("cnonce", get: { $0.cnonce }, set: { $0.cnonce = $1 }),
        Type<Authenticate>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
}

extension AssignRoles : JsonSerializable
{
    public static var typeName:String { return "AssignRoles" }
    public static var metadata = Metadata.create([
        Type<AssignRoles>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        Type<AssignRoles>.arrayProperty("permissions", get: { $0.permissions }, set: { $0.permissions = $1 }),
        Type<AssignRoles>.arrayProperty("roles", get: { $0.roles }, set: { $0.roles = $1 }),
        ])
}

extension UnAssignRoles : JsonSerializable
{
    public static var typeName:String { return "UnAssignRoles" }
    public static var metadata = Metadata.create([
        Type<UnAssignRoles>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        Type<UnAssignRoles>.arrayProperty("permissions", get: { $0.permissions }, set: { $0.permissions = $1 }),
        Type<UnAssignRoles>.arrayProperty("roles", get: { $0.roles }, set: { $0.roles = $1 }),
        ])
}

extension GetAutoQueryServicesResponse : JsonSerializable
{
    public static var typeName:String { return "GetAutoQueryServicesResponse" }
    public static var metadata = Metadata.create([
        Type<GetAutoQueryServicesResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        Type<GetAutoQueryServicesResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension RegisterAutoQueryServiceResponse : JsonSerializable
{
    public static var typeName:String { return "RegisterAutoQueryServiceResponse" }
    public static var metadata = Metadata.create([
        Type<RegisterAutoQueryServiceResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        Type<RegisterAutoQueryServiceResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension AuthenticateResponse : JsonSerializable
{
    public static var typeName:String { return "AuthenticateResponse" }
    public static var metadata = Metadata.create([
        Type<AuthenticateResponse>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
        Type<AuthenticateResponse>.optionalProperty("sessionId", get: { $0.sessionId }, set: { $0.sessionId = $1 }),
        Type<AuthenticateResponse>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        Type<AuthenticateResponse>.optionalProperty("displayName", get: { $0.displayName }, set: { $0.displayName = $1 }),
        Type<AuthenticateResponse>.optionalProperty("referrerUrl", get: { $0.referrerUrl }, set: { $0.referrerUrl = $1 }),
        Type<AuthenticateResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        Type<AuthenticateResponse>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
}

extension AssignRolesResponse : JsonSerializable
{
    public static var typeName:String { return "AssignRolesResponse" }
    public static var metadata = Metadata.create([
        Type<AssignRolesResponse>.arrayProperty("allRoles", get: { $0.allRoles }, set: { $0.allRoles = $1 }),
        Type<AssignRolesResponse>.arrayProperty("allPermissions", get: { $0.allPermissions }, set: { $0.allPermissions = $1 }),
        Type<AssignRolesResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UnAssignRolesResponse : JsonSerializable
{
    public static var typeName:String { return "UnAssignRolesResponse" }
    public static var metadata = Metadata.create([
        Type<UnAssignRolesResponse>.arrayProperty("allRoles", get: { $0.allRoles }, set: { $0.allRoles = $1 }),
        Type<UnAssignRolesResponse>.arrayProperty("allPermissions", get: { $0.allPermissions }, set: { $0.allPermissions = $1 }),
        Type<UnAssignRolesResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension AutoQueryService : JsonSerializable
{
    public static var typeName:String { return "AutoQueryService" }
    public static var metadata = Metadata.create([
        Type<AutoQueryService>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<AutoQueryService>.optionalProperty("serviceBaseUrl", get: { $0.serviceBaseUrl }, set: { $0.serviceBaseUrl = $1 }),
        Type<AutoQueryService>.optionalProperty("serviceName", get: { $0.serviceName }, set: { $0.serviceName = $1 }),
        Type<AutoQueryService>.optionalProperty("serviceDescription", get: { $0.serviceDescription }, set: { $0.serviceDescription = $1 }),
        Type<AutoQueryService>.optionalProperty("serviceIconUrl", get: { $0.serviceIconUrl }, set: { $0.serviceIconUrl = $1 }),
        Type<AutoQueryService>.optionalProperty("isPublic", get: { $0.isPublic }, set: { $0.isPublic = $1 }),
        Type<AutoQueryService>.optionalProperty("onlyShowAnnotatedServices", get: { $0.onlyShowAnnotatedServices }, set: { $0.onlyShowAnnotatedServices = $1 }),
        Type<AutoQueryService>.arrayProperty("implicitConventions", get: { $0.implicitConventions }, set: { $0.implicitConventions = $1 }),
        Type<AutoQueryService>.optionalProperty("defaultSearchField", get: { $0.defaultSearchField }, set: { $0.defaultSearchField = $1 }),
        Type<AutoQueryService>.optionalProperty("defaultSearchType", get: { $0.defaultSearchType }, set: { $0.defaultSearchType = $1 }),
        Type<AutoQueryService>.optionalProperty("defaultSearchText", get: { $0.defaultSearchText }, set: { $0.defaultSearchText = $1 }),
        Type<AutoQueryService>.optionalProperty("brandUrl", get: { $0.brandUrl }, set: { $0.brandUrl = $1 }),
        Type<AutoQueryService>.optionalProperty("brandImageUrl", get: { $0.brandImageUrl }, set: { $0.brandImageUrl = $1 }),
        Type<AutoQueryService>.optionalProperty("textColor", get: { $0.textColor }, set: { $0.textColor = $1 }),
        Type<AutoQueryService>.optionalProperty("linkColor", get: { $0.linkColor }, set: { $0.linkColor = $1 }),
        Type<AutoQueryService>.optionalProperty("backgroundColor", get: { $0.backgroundColor }, set: { $0.backgroundColor = $1 }),
        Type<AutoQueryService>.optionalProperty("backgroundImageUrl", get: { $0.backgroundImageUrl }, set: { $0.backgroundImageUrl = $1 }),
        Type<AutoQueryService>.optionalProperty("iconUrl", get: { $0.iconUrl }, set: { $0.iconUrl = $1 }),
        Type<AutoQueryService>.optionalProperty("ownerId", get: { $0.ownerId }, set: { $0.ownerId = $1 }),
        Type<AutoQueryService>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
        Type<AutoQueryService>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
        Type<AutoQueryService>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
        Type<AutoQueryService>.optionalProperty("lastModifiedBy", get: { $0.lastModifiedBy }, set: { $0.lastModifiedBy = $1 }),
        ])
}

extension AutoQueryMetadata : JsonSerializable
{
    public static var typeName:String { return "AutoQueryMetadata" }
    public static var metadata = Metadata.create([
        ])
}

extension AutoQueryMetadataResponse : JsonSerializable
{
    public static var typeName:String { return "AutoQueryMetadataResponse" }
    public static var metadata = Metadata.create([
        Type<AutoQueryMetadataResponse>.optionalObjectProperty("config", get: { $0.config }, set: { $0.config = $1 }),
        Type<AutoQueryMetadataResponse>.arrayProperty("operations", get: { $0.operations }, set: { $0.operations = $1 }),
        Type<AutoQueryMetadataResponse>.arrayProperty("types", get: { $0.types }, set: { $0.types = $1 }),
        Type<AutoQueryMetadataResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension Property : JsonSerializable
{
    public static var typeName:String { return "Property" }
    public static var metadata = Metadata.create([
        Type<Property>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<Property>.optionalProperty("value", get: { $0.value }, set: { $0.value = $1 }),
        ])
}

extension AutoQueryViewerConfig : JsonSerializable
{
    public static var typeName:String { return "AutoQueryViewerConfig" }
    public static var metadata = Metadata.create([
        Type<AutoQueryViewerConfig>.optionalProperty("serviceBaseUrl", get: { $0.serviceBaseUrl }, set: { $0.serviceBaseUrl = $1 }),
        Type<AutoQueryViewerConfig>.optionalProperty("serviceName", get: { $0.serviceName }, set: { $0.serviceName = $1 }),
        Type<AutoQueryViewerConfig>.optionalProperty("serviceDescription", get: { $0.serviceDescription }, set: { $0.serviceDescription = $1 }),
        Type<AutoQueryViewerConfig>.optionalProperty("serviceIconUrl", get: { $0.serviceIconUrl }, set: { $0.serviceIconUrl = $1 }),
        Type<AutoQueryViewerConfig>.optionalProperty("isPublic", get: { $0.isPublic }, set: { $0.isPublic = $1 }),
        Type<AutoQueryViewerConfig>.optionalProperty("onlyShowAnnotatedServices", get: { $0.onlyShowAnnotatedServices }, set: { $0.onlyShowAnnotatedServices = $1 }),
        Type<AutoQueryViewerConfig>.arrayProperty("implicitConventions", get: { $0.implicitConventions }, set: { $0.implicitConventions = $1 }),
        Type<AutoQueryViewerConfig>.optionalProperty("defaultSearchField", get: { $0.defaultSearchField }, set: { $0.defaultSearchField = $1 }),
        Type<AutoQueryViewerConfig>.optionalProperty("defaultSearchType", get: { $0.defaultSearchType }, set: { $0.defaultSearchType = $1 }),
        Type<AutoQueryViewerConfig>.optionalProperty("defaultSearchText", get: { $0.defaultSearchText }, set: { $0.defaultSearchText = $1 }),
        Type<AutoQueryViewerConfig>.optionalProperty("brandUrl", get: { $0.brandUrl }, set: { $0.brandUrl = $1 }),
        Type<AutoQueryViewerConfig>.optionalProperty("brandImageUrl", get: { $0.brandImageUrl }, set: { $0.brandImageUrl = $1 }),
        Type<AutoQueryViewerConfig>.optionalProperty("textColor", get: { $0.textColor }, set: { $0.textColor = $1 }),
        Type<AutoQueryViewerConfig>.optionalProperty("linkColor", get: { $0.linkColor }, set: { $0.linkColor = $1 }),
        Type<AutoQueryViewerConfig>.optionalProperty("backgroundColor", get: { $0.backgroundColor }, set: { $0.backgroundColor = $1 }),
        Type<AutoQueryViewerConfig>.optionalProperty("backgroundImageUrl", get: { $0.backgroundImageUrl }, set: { $0.backgroundImageUrl = $1 }),
        Type<AutoQueryViewerConfig>.optionalProperty("iconUrl", get: { $0.iconUrl }, set: { $0.iconUrl = $1 }),
        ])
}

extension AutoQueryOperation : JsonSerializable
{
    public static var typeName:String { return "AutoQueryOperation" }
    public static var metadata = Metadata.create([
        Type<AutoQueryOperation>.optionalProperty("request", get: { $0.request }, set: { $0.request = $1 }),
        Type<AutoQueryOperation>.optionalProperty("from", get: { $0.from }, set: { $0.from = $1 }),
        Type<AutoQueryOperation>.optionalProperty("to", get: { $0.to }, set: { $0.to = $1 }),
        ])
}

extension MetadataType : JsonSerializable
{
    public static var typeName:String { return "MetadataType" }
    public static var metadata = Metadata.create([
        Type<MetadataType>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<MetadataType>.optionalProperty("namespace", get: { $0.namespace }, set: { $0.namespace = $1 }),
        Type<MetadataType>.arrayProperty("genericArgs", get: { $0.genericArgs }, set: { $0.genericArgs = $1 }),
        Type<MetadataType>.optionalObjectProperty("inherits", get: { $0.inherits }, set: { $0.inherits = $1 }),
        Type<MetadataType>.arrayProperty("implements", get: { $0.implements }, set: { $0.implements = $1 }),
        Type<MetadataType>.optionalProperty("displayType", get: { $0.displayType }, set: { $0.displayType = $1 }),
        Type<MetadataType>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
        Type<MetadataType>.optionalProperty("returnVoidMarker", get: { $0.returnVoidMarker }, set: { $0.returnVoidMarker = $1 }),
        Type<MetadataType>.optionalProperty("isNested", get: { $0.isNested }, set: { $0.isNested = $1 }),
        Type<MetadataType>.optionalProperty("isEnum", get: { $0.isEnum }, set: { $0.isEnum = $1 }),
        Type<MetadataType>.optionalProperty("isInterface", get: { $0.isInterface }, set: { $0.isInterface = $1 }),
        Type<MetadataType>.optionalProperty("isAbstract", get: { $0.isAbstract }, set: { $0.isAbstract = $1 }),
        Type<MetadataType>.optionalObjectProperty("returnMarkerTypeName", get: { $0.returnMarkerTypeName }, set: { $0.returnMarkerTypeName = $1 }),
        Type<MetadataType>.arrayProperty("routes", get: { $0.routes }, set: { $0.routes = $1 }),
        Type<MetadataType>.optionalObjectProperty("dataContract", get: { $0.dataContract }, set: { $0.dataContract = $1 }),
        Type<MetadataType>.arrayProperty("properties", get: { $0.properties }, set: { $0.properties = $1 }),
        Type<MetadataType>.arrayProperty("attributes", get: { $0.attributes }, set: { $0.attributes = $1 }),
        Type<MetadataType>.arrayProperty("innerTypes", get: { $0.innerTypes }, set: { $0.innerTypes = $1 }),
        Type<MetadataType>.arrayProperty("enumNames", get: { $0.enumNames }, set: { $0.enumNames = $1 }),
        Type<MetadataType>.arrayProperty("enumValues", get: { $0.enumValues }, set: { $0.enumValues = $1 }),
        ])
}

extension MetadataTypeName : JsonSerializable
{
    public static var typeName:String { return "MetadataTypeName" }
    public static var metadata = Metadata.create([
        Type<MetadataTypeName>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<MetadataTypeName>.optionalProperty("namespace", get: { $0.namespace }, set: { $0.namespace = $1 }),
        Type<MetadataTypeName>.arrayProperty("genericArgs", get: { $0.genericArgs }, set: { $0.genericArgs = $1 }),
        ])
}

extension MetadataRoute : JsonSerializable
{
    public static var typeName:String { return "MetadataRoute" }
    public static var metadata = Metadata.create([
        Type<MetadataRoute>.optionalProperty("path", get: { $0.path }, set: { $0.path = $1 }),
        Type<MetadataRoute>.optionalProperty("verbs", get: { $0.verbs }, set: { $0.verbs = $1 }),
        Type<MetadataRoute>.optionalProperty("notes", get: { $0.notes }, set: { $0.notes = $1 }),
        Type<MetadataRoute>.optionalProperty("summary", get: { $0.summary }, set: { $0.summary = $1 }),
        ])
}

extension MetadataDataContract : JsonSerializable
{
    public static var typeName:String { return "MetadataDataContract" }
    public static var metadata = Metadata.create([
        Type<MetadataDataContract>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<MetadataDataContract>.optionalProperty("namespace", get: { $0.namespace }, set: { $0.namespace = $1 }),
        ])
}

extension MetadataPropertyType : JsonSerializable
{
    public static var typeName:String { return "MetadataPropertyType" }
    public static var metadata = Metadata.create([
        Type<MetadataPropertyType>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<MetadataPropertyType>.optionalProperty("type", get: { $0.type }, set: { $0.type = $1 }),
        Type<MetadataPropertyType>.optionalProperty("isValueType", get: { $0.isValueType }, set: { $0.isValueType = $1 }),
        Type<MetadataPropertyType>.optionalProperty("typeNamespace", get: { $0.typeNamespace }, set: { $0.typeNamespace = $1 }),
        Type<MetadataPropertyType>.arrayProperty("genericArgs", get: { $0.genericArgs }, set: { $0.genericArgs = $1 }),
        Type<MetadataPropertyType>.optionalProperty("value", get: { $0.value }, set: { $0.value = $1 }),
        Type<MetadataPropertyType>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
        Type<MetadataPropertyType>.optionalObjectProperty("dataMember", get: { $0.dataMember }, set: { $0.dataMember = $1 }),
        Type<MetadataPropertyType>.optionalProperty("readOnly", get: { $0.readOnly }, set: { $0.readOnly = $1 }),
        Type<MetadataPropertyType>.optionalProperty("paramType", get: { $0.paramType }, set: { $0.paramType = $1 }),
        Type<MetadataPropertyType>.optionalProperty("displayType", get: { $0.displayType }, set: { $0.displayType = $1 }),
        Type<MetadataPropertyType>.optionalProperty("isRequired", get: { $0.isRequired }, set: { $0.isRequired = $1 }),
        Type<MetadataPropertyType>.arrayProperty("allowableValues", get: { $0.allowableValues }, set: { $0.allowableValues = $1 }),
        Type<MetadataPropertyType>.optionalProperty("allowableMin", get: { $0.allowableMin }, set: { $0.allowableMin = $1 }),
        Type<MetadataPropertyType>.optionalProperty("allowableMax", get: { $0.allowableMax }, set: { $0.allowableMax = $1 }),
        Type<MetadataPropertyType>.arrayProperty("attributes", get: { $0.attributes }, set: { $0.attributes = $1 }),
        ])
}

extension MetadataAttribute : JsonSerializable
{
    public static var typeName:String { return "MetadataAttribute" }
    public static var metadata = Metadata.create([
        Type<MetadataAttribute>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<MetadataAttribute>.arrayProperty("constructorArgs", get: { $0.constructorArgs }, set: { $0.constructorArgs = $1 }),
        Type<MetadataAttribute>.arrayProperty("args", get: { $0.args }, set: { $0.args = $1 }),
        ])
}

extension MetadataDataMember : JsonSerializable
{
    public static var typeName:String { return "MetadataDataMember" }
    public static var metadata = Metadata.create([
        Type<MetadataDataMember>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<MetadataDataMember>.optionalProperty("order", get: { $0.order }, set: { $0.order = $1 }),
        Type<MetadataDataMember>.optionalProperty("isRequired", get: { $0.isRequired }, set: { $0.isRequired = $1 }),
        Type<MetadataDataMember>.optionalProperty("emitDefaultValue", get: { $0.emitDefaultValue }, set: { $0.emitDefaultValue = $1 }),
        ])
}
