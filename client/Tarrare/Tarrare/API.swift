// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class AllDeliveriesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query AllDeliveries {
      allDeliveries {
        __typename
        id
        orderStatus
        userId
        user {
          __typename
          ...UserInfo
        }
        resturantPlaceId
        resturant {
          __typename
          placeId
          place {
            __typename
            ...PlaceInfo
          }
        }
        deliveryBuildingPlaceId
        deliveryBuilding {
          __typename
          placeId
          place {
            __typename
            ...PlaceInfo
          }
        }
      }
    }
    """

  public let operationName: String = "AllDeliveries"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + UserInfo.fragmentDefinition)
    document.append("\n" + PlaceInfo.fragmentDefinition)
    return document
  }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("allDeliveries", type: .nonNull(.list(.object(AllDelivery.selections)))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allDeliveries: [AllDelivery?]) {
      self.init(unsafeResultMap: ["__typename": "Query", "allDeliveries": allDeliveries.map { (value: AllDelivery?) -> ResultMap? in value.flatMap { (value: AllDelivery) -> ResultMap in value.resultMap } }])
    }

    public var allDeliveries: [AllDelivery?] {
      get {
        return (resultMap["allDeliveries"] as! [ResultMap?]).map { (value: ResultMap?) -> AllDelivery? in value.flatMap { (value: ResultMap) -> AllDelivery in AllDelivery(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AllDelivery?) -> ResultMap? in value.flatMap { (value: AllDelivery) -> ResultMap in value.resultMap } }, forKey: "allDeliveries")
      }
    }

    public struct AllDelivery: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Delivery"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("orderStatus", type: .nonNull(.scalar(String.self))),
          GraphQLField("userId", type: .nonNull(.scalar(Int.self))),
          GraphQLField("user", type: .object(User.selections)),
          GraphQLField("resturantPlaceId", type: .nonNull(.scalar(Int.self))),
          GraphQLField("resturant", type: .object(Resturant.selections)),
          GraphQLField("deliveryBuildingPlaceId", type: .nonNull(.scalar(Int.self))),
          GraphQLField("deliveryBuilding", type: .object(DeliveryBuilding.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, orderStatus: String, userId: Int, user: User? = nil, resturantPlaceId: Int, resturant: Resturant? = nil, deliveryBuildingPlaceId: Int, deliveryBuilding: DeliveryBuilding? = nil) {
        self.init(unsafeResultMap: ["__typename": "Delivery", "id": id, "orderStatus": orderStatus, "userId": userId, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }, "resturantPlaceId": resturantPlaceId, "resturant": resturant.flatMap { (value: Resturant) -> ResultMap in value.resultMap }, "deliveryBuildingPlaceId": deliveryBuildingPlaceId, "deliveryBuilding": deliveryBuilding.flatMap { (value: DeliveryBuilding) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var orderStatus: String {
        get {
          return resultMap["orderStatus"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "orderStatus")
        }
      }

      public var userId: Int {
        get {
          return resultMap["userId"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "userId")
        }
      }

      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public var resturantPlaceId: Int {
        get {
          return resultMap["resturantPlaceId"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "resturantPlaceId")
        }
      }

      public var resturant: Resturant? {
        get {
          return (resultMap["resturant"] as? ResultMap).flatMap { Resturant(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "resturant")
        }
      }

      public var deliveryBuildingPlaceId: Int {
        get {
          return resultMap["deliveryBuildingPlaceId"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "deliveryBuildingPlaceId")
        }
      }

      public var deliveryBuilding: DeliveryBuilding? {
        get {
          return (resultMap["deliveryBuilding"] as? ResultMap).flatMap { DeliveryBuilding(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "deliveryBuilding")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(UserInfo.self),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(email: String, id: Int, firstName: String, lastName: String, delivering: Bool) {
          self.init(unsafeResultMap: ["__typename": "User", "email": email, "id": id, "firstName": firstName, "lastName": lastName, "delivering": delivering])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var userInfo: UserInfo {
            get {
              return UserInfo(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }

      public struct Resturant: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Resturant"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("placeId", type: .nonNull(.scalar(Int.self))),
            GraphQLField("place", type: .object(Place.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(placeId: Int, place: Place? = nil) {
          self.init(unsafeResultMap: ["__typename": "Resturant", "placeId": placeId, "place": place.flatMap { (value: Place) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var placeId: Int {
          get {
            return resultMap["placeId"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeId")
          }
        }

        public var place: Place? {
          get {
            return (resultMap["place"] as? ResultMap).flatMap { Place(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "place")
          }
        }

        public struct Place: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Place"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(PlaceInfo.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int, name: String, fullAddress: String, state: String, city: String, zipcode: Int, googlePlaceId: String) {
            self.init(unsafeResultMap: ["__typename": "Place", "id": id, "name": name, "fullAddress": fullAddress, "state": state, "city": city, "zipcode": zipcode, "googlePlaceId": googlePlaceId])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var placeInfo: PlaceInfo {
              get {
                return PlaceInfo(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }

      public struct DeliveryBuilding: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["DeliveryBuilding"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("placeId", type: .nonNull(.scalar(Int.self))),
            GraphQLField("place", type: .object(Place.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(placeId: Int, place: Place? = nil) {
          self.init(unsafeResultMap: ["__typename": "DeliveryBuilding", "placeId": placeId, "place": place.flatMap { (value: Place) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var placeId: Int {
          get {
            return resultMap["placeId"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeId")
          }
        }

        public var place: Place? {
          get {
            return (resultMap["place"] as? ResultMap).flatMap { Place(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "place")
          }
        }

        public struct Place: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Place"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(PlaceInfo.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int, name: String, fullAddress: String, state: String, city: String, zipcode: Int, googlePlaceId: String) {
            self.init(unsafeResultMap: ["__typename": "Place", "id": id, "name": name, "fullAddress": fullAddress, "state": state, "city": city, "zipcode": zipcode, "googlePlaceId": googlePlaceId])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var placeInfo: PlaceInfo {
              get {
                return PlaceInfo(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public final class CreatePlaceMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CreatePlace($name: String!, $fullAddress: String!, $state: String!, $city: String!, $zipcode: Int!, $googlePlaceId: String!) {
      createPlace(
        name: $name
        fullAddress: $fullAddress
        state: $state
        city: $city
        zipcode: $zipcode
        googlePlaceId: $googlePlaceId
      ) {
        __typename
        ...PlaceInfo
      }
    }
    """

  public let operationName: String = "CreatePlace"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + PlaceInfo.fragmentDefinition)
    return document
  }

  public var name: String
  public var fullAddress: String
  public var state: String
  public var city: String
  public var zipcode: Int
  public var googlePlaceId: String

  public init(name: String, fullAddress: String, state: String, city: String, zipcode: Int, googlePlaceId: String) {
    self.name = name
    self.fullAddress = fullAddress
    self.state = state
    self.city = city
    self.zipcode = zipcode
    self.googlePlaceId = googlePlaceId
  }

  public var variables: GraphQLMap? {
    return ["name": name, "fullAddress": fullAddress, "state": state, "city": city, "zipcode": zipcode, "googlePlaceId": googlePlaceId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createPlace", arguments: ["name": GraphQLVariable("name"), "fullAddress": GraphQLVariable("fullAddress"), "state": GraphQLVariable("state"), "city": GraphQLVariable("city"), "zipcode": GraphQLVariable("zipcode"), "googlePlaceId": GraphQLVariable("googlePlaceId")], type: .object(CreatePlace.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createPlace: CreatePlace? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createPlace": createPlace.flatMap { (value: CreatePlace) -> ResultMap in value.resultMap }])
    }

    public var createPlace: CreatePlace? {
      get {
        return (resultMap["createPlace"] as? ResultMap).flatMap { CreatePlace(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createPlace")
      }
    }

    public struct CreatePlace: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Place"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(PlaceInfo.self),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, name: String, fullAddress: String, state: String, city: String, zipcode: Int, googlePlaceId: String) {
        self.init(unsafeResultMap: ["__typename": "Place", "id": id, "name": name, "fullAddress": fullAddress, "state": state, "city": city, "zipcode": zipcode, "googlePlaceId": googlePlaceId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var placeInfo: PlaceInfo {
          get {
            return PlaceInfo(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public final class LoginUserMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation LoginUser($email: String!, $password: String!) {
      login(email: $email, password: $password) {
        __typename
        email
        id
        firstName
        lastName
        delivering
      }
    }
    """

  public let operationName: String = "LoginUser"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("login", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .object(Login.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(login: Login? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "login": login.flatMap { (value: Login) -> ResultMap in value.resultMap }])
    }

    public var login: Login? {
      get {
        return (resultMap["login"] as? ResultMap).flatMap { Login(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "login")
      }
    }

    public struct Login: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
          GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
          GraphQLField("delivering", type: .nonNull(.scalar(Bool.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(email: String, id: Int, firstName: String, lastName: String, delivering: Bool) {
        self.init(unsafeResultMap: ["__typename": "User", "email": email, "id": id, "firstName": firstName, "lastName": lastName, "delivering": delivering])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var firstName: String {
        get {
          return resultMap["firstName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstName")
        }
      }

      public var lastName: String {
        get {
          return resultMap["lastName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lastName")
        }
      }

      public var delivering: Bool {
        get {
          return resultMap["delivering"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "delivering")
        }
      }
    }
  }
}

public final class RegisterUserMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation RegisterUser($firstName: String!, $lastName: String!, $email: String!, $password: String!) {
      register(
        firstName: $firstName
        lastName: $lastName
        email: $email
        password: $password
      ) {
        __typename
        id
        email
        firstName
        lastName
        delivering
      }
    }
    """

  public let operationName: String = "RegisterUser"

  public var firstName: String
  public var lastName: String
  public var email: String
  public var password: String

  public init(firstName: String, lastName: String, email: String, password: String) {
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["firstName": firstName, "lastName": lastName, "email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("register", arguments: ["firstName": GraphQLVariable("firstName"), "lastName": GraphQLVariable("lastName"), "email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .object(Register.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(register: Register? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "register": register.flatMap { (value: Register) -> ResultMap in value.resultMap }])
    }

    public var register: Register? {
      get {
        return (resultMap["register"] as? ResultMap).flatMap { Register(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "register")
      }
    }

    public struct Register: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
          GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
          GraphQLField("delivering", type: .nonNull(.scalar(Bool.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, email: String, firstName: String, lastName: String, delivering: Bool) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "email": email, "firstName": firstName, "lastName": lastName, "delivering": delivering])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var email: String {
        get {
          return resultMap["email"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var firstName: String {
        get {
          return resultMap["firstName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstName")
        }
      }

      public var lastName: String {
        get {
          return resultMap["lastName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lastName")
        }
      }

      public var delivering: Bool {
        get {
          return resultMap["delivering"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "delivering")
        }
      }
    }
  }
}

public final class ToggleUserDeliveryStatusMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation ToggleUserDeliveryStatus($id: Int!, $delivering: Boolean!) {
      toggleUserDeliveryStatus(id: $id, delivering: $delivering) {
        __typename
        ...UserInfo
      }
    }
    """

  public let operationName: String = "ToggleUserDeliveryStatus"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + UserInfo.fragmentDefinition)
    return document
  }

  public var id: Int
  public var delivering: Bool

  public init(id: Int, delivering: Bool) {
    self.id = id
    self.delivering = delivering
  }

  public var variables: GraphQLMap? {
    return ["id": id, "delivering": delivering]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("toggleUserDeliveryStatus", arguments: ["id": GraphQLVariable("id"), "delivering": GraphQLVariable("delivering")], type: .object(ToggleUserDeliveryStatus.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(toggleUserDeliveryStatus: ToggleUserDeliveryStatus? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "toggleUserDeliveryStatus": toggleUserDeliveryStatus.flatMap { (value: ToggleUserDeliveryStatus) -> ResultMap in value.resultMap }])
    }

    public var toggleUserDeliveryStatus: ToggleUserDeliveryStatus? {
      get {
        return (resultMap["toggleUserDeliveryStatus"] as? ResultMap).flatMap { ToggleUserDeliveryStatus(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "toggleUserDeliveryStatus")
      }
    }

    public struct ToggleUserDeliveryStatus: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(UserInfo.self),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(email: String, id: Int, firstName: String, lastName: String, delivering: Bool) {
        self.init(unsafeResultMap: ["__typename": "User", "email": email, "id": id, "firstName": firstName, "lastName": lastName, "delivering": delivering])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var userInfo: UserInfo {
          get {
            return UserInfo(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public final class UpsertDeliveryMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UpsertDelivery($userId: Int!, $orderStatus: String!, $resturantPlaceId: Int, $deliveryBuildingPlaceId: Int) {
      upsertDelivery(
        userId: $userId
        orderStatus: $orderStatus
        resturantPlaceId: $resturantPlaceId
        deliveryBuildingPlaceId: $deliveryBuildingPlaceId
      ) {
        __typename
        id
        userId
        user {
          __typename
          ...UserInfo
        }
        orderStatus
        resturantPlaceId
        resturant {
          __typename
          placeId
          place {
            __typename
            ...PlaceInfo
          }
        }
        deliveryBuilding {
          __typename
          placeId
          place {
            __typename
            ...PlaceInfo
          }
        }
        deliveryBuildingPlaceId
      }
    }
    """

  public let operationName: String = "UpsertDelivery"

  public var queryDocument: String {
    var document: String = operationDefinition
    document.append("\n" + UserInfo.fragmentDefinition)
    document.append("\n" + PlaceInfo.fragmentDefinition)
    return document
  }

  public var userId: Int
  public var orderStatus: String
  public var resturantPlaceId: Int?
  public var deliveryBuildingPlaceId: Int?

  public init(userId: Int, orderStatus: String, resturantPlaceId: Int? = nil, deliveryBuildingPlaceId: Int? = nil) {
    self.userId = userId
    self.orderStatus = orderStatus
    self.resturantPlaceId = resturantPlaceId
    self.deliveryBuildingPlaceId = deliveryBuildingPlaceId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId, "orderStatus": orderStatus, "resturantPlaceId": resturantPlaceId, "deliveryBuildingPlaceId": deliveryBuildingPlaceId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("upsertDelivery", arguments: ["userId": GraphQLVariable("userId"), "orderStatus": GraphQLVariable("orderStatus"), "resturantPlaceId": GraphQLVariable("resturantPlaceId"), "deliveryBuildingPlaceId": GraphQLVariable("deliveryBuildingPlaceId")], type: .object(UpsertDelivery.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(upsertDelivery: UpsertDelivery? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "upsertDelivery": upsertDelivery.flatMap { (value: UpsertDelivery) -> ResultMap in value.resultMap }])
    }

    public var upsertDelivery: UpsertDelivery? {
      get {
        return (resultMap["upsertDelivery"] as? ResultMap).flatMap { UpsertDelivery(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "upsertDelivery")
      }
    }

    public struct UpsertDelivery: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Delivery"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("userId", type: .nonNull(.scalar(Int.self))),
          GraphQLField("user", type: .object(User.selections)),
          GraphQLField("orderStatus", type: .nonNull(.scalar(String.self))),
          GraphQLField("resturantPlaceId", type: .nonNull(.scalar(Int.self))),
          GraphQLField("resturant", type: .object(Resturant.selections)),
          GraphQLField("deliveryBuilding", type: .object(DeliveryBuilding.selections)),
          GraphQLField("deliveryBuildingPlaceId", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, userId: Int, user: User? = nil, orderStatus: String, resturantPlaceId: Int, resturant: Resturant? = nil, deliveryBuilding: DeliveryBuilding? = nil, deliveryBuildingPlaceId: Int) {
        self.init(unsafeResultMap: ["__typename": "Delivery", "id": id, "userId": userId, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }, "orderStatus": orderStatus, "resturantPlaceId": resturantPlaceId, "resturant": resturant.flatMap { (value: Resturant) -> ResultMap in value.resultMap }, "deliveryBuilding": deliveryBuilding.flatMap { (value: DeliveryBuilding) -> ResultMap in value.resultMap }, "deliveryBuildingPlaceId": deliveryBuildingPlaceId])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var userId: Int {
        get {
          return resultMap["userId"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "userId")
        }
      }

      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public var orderStatus: String {
        get {
          return resultMap["orderStatus"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "orderStatus")
        }
      }

      public var resturantPlaceId: Int {
        get {
          return resultMap["resturantPlaceId"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "resturantPlaceId")
        }
      }

      public var resturant: Resturant? {
        get {
          return (resultMap["resturant"] as? ResultMap).flatMap { Resturant(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "resturant")
        }
      }

      public var deliveryBuilding: DeliveryBuilding? {
        get {
          return (resultMap["deliveryBuilding"] as? ResultMap).flatMap { DeliveryBuilding(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "deliveryBuilding")
        }
      }

      public var deliveryBuildingPlaceId: Int {
        get {
          return resultMap["deliveryBuildingPlaceId"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "deliveryBuildingPlaceId")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["User"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(UserInfo.self),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(email: String, id: Int, firstName: String, lastName: String, delivering: Bool) {
          self.init(unsafeResultMap: ["__typename": "User", "email": email, "id": id, "firstName": firstName, "lastName": lastName, "delivering": delivering])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var userInfo: UserInfo {
            get {
              return UserInfo(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }

      public struct Resturant: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Resturant"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("placeId", type: .nonNull(.scalar(Int.self))),
            GraphQLField("place", type: .object(Place.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(placeId: Int, place: Place? = nil) {
          self.init(unsafeResultMap: ["__typename": "Resturant", "placeId": placeId, "place": place.flatMap { (value: Place) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var placeId: Int {
          get {
            return resultMap["placeId"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeId")
          }
        }

        public var place: Place? {
          get {
            return (resultMap["place"] as? ResultMap).flatMap { Place(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "place")
          }
        }

        public struct Place: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Place"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(PlaceInfo.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int, name: String, fullAddress: String, state: String, city: String, zipcode: Int, googlePlaceId: String) {
            self.init(unsafeResultMap: ["__typename": "Place", "id": id, "name": name, "fullAddress": fullAddress, "state": state, "city": city, "zipcode": zipcode, "googlePlaceId": googlePlaceId])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var placeInfo: PlaceInfo {
              get {
                return PlaceInfo(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }

      public struct DeliveryBuilding: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["DeliveryBuilding"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("placeId", type: .nonNull(.scalar(Int.self))),
            GraphQLField("place", type: .object(Place.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(placeId: Int, place: Place? = nil) {
          self.init(unsafeResultMap: ["__typename": "DeliveryBuilding", "placeId": placeId, "place": place.flatMap { (value: Place) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var placeId: Int {
          get {
            return resultMap["placeId"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeId")
          }
        }

        public var place: Place? {
          get {
            return (resultMap["place"] as? ResultMap).flatMap { Place(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "place")
          }
        }

        public struct Place: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Place"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(PlaceInfo.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int, name: String, fullAddress: String, state: String, city: String, zipcode: Int, googlePlaceId: String) {
            self.init(unsafeResultMap: ["__typename": "Place", "id": id, "name": name, "fullAddress": fullAddress, "state": state, "city": city, "zipcode": zipcode, "googlePlaceId": googlePlaceId])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var placeInfo: PlaceInfo {
              get {
                return PlaceInfo(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public struct UserInfo: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment UserInfo on User {
      __typename
      email
      id
      firstName
      lastName
      delivering
    }
    """

  public static let possibleTypes: [String] = ["User"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("email", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(Int.self))),
      GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
      GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
      GraphQLField("delivering", type: .nonNull(.scalar(Bool.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(email: String, id: Int, firstName: String, lastName: String, delivering: Bool) {
    self.init(unsafeResultMap: ["__typename": "User", "email": email, "id": id, "firstName": firstName, "lastName": lastName, "delivering": delivering])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var email: String {
    get {
      return resultMap["email"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "email")
    }
  }

  public var id: Int {
    get {
      return resultMap["id"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var firstName: String {
    get {
      return resultMap["firstName"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "firstName")
    }
  }

  public var lastName: String {
    get {
      return resultMap["lastName"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "lastName")
    }
  }

  public var delivering: Bool {
    get {
      return resultMap["delivering"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "delivering")
    }
  }
}

public struct PlaceInfo: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment PlaceInfo on Place {
      __typename
      id
      name
      fullAddress
      state
      city
      zipcode
      googlePlaceId
    }
    """

  public static let possibleTypes: [String] = ["Place"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(Int.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
      GraphQLField("fullAddress", type: .nonNull(.scalar(String.self))),
      GraphQLField("state", type: .nonNull(.scalar(String.self))),
      GraphQLField("city", type: .nonNull(.scalar(String.self))),
      GraphQLField("zipcode", type: .nonNull(.scalar(Int.self))),
      GraphQLField("googlePlaceId", type: .nonNull(.scalar(String.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: Int, name: String, fullAddress: String, state: String, city: String, zipcode: Int, googlePlaceId: String) {
    self.init(unsafeResultMap: ["__typename": "Place", "id": id, "name": name, "fullAddress": fullAddress, "state": state, "city": city, "zipcode": zipcode, "googlePlaceId": googlePlaceId])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: Int {
    get {
      return resultMap["id"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var fullAddress: String {
    get {
      return resultMap["fullAddress"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "fullAddress")
    }
  }

  public var state: String {
    get {
      return resultMap["state"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "state")
    }
  }

  public var city: String {
    get {
      return resultMap["city"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "city")
    }
  }

  public var zipcode: Int {
    get {
      return resultMap["zipcode"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "zipcode")
    }
  }

  public var googlePlaceId: String {
    get {
      return resultMap["googlePlaceId"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "googlePlaceId")
    }
  }
}
