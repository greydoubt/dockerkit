from cloudflare.types import (
    ASN,
    AuditLog,
    CertificateCA,
    CertificateRequestType,
    CloudflareTunnel,
    ErrorData,
    Identifier,
    LoadBalancerPreview,
    Member,
    PaginationInfo,
    Permission,
    PermissionGrant,
    RatePlan,
    ResponseInfo,
    Result,
    Role,
    SortDirection,
    Subscription,
    SubscriptionComponent,
    SubscriptionZone,
    Token,
    TokenConditionCIDRList,
    TokenPolicy,
    TokenValue,
)

from cloudflare.types.accounts import Account, AccountDeleteResponse

Methods:

    client.accounts.create(**params) -> Optional[Account]
    client.accounts.update(*, account_id, **params) -> Optional[Account]
    client.accounts.list(**params) -> SyncV4PagePaginationArray[Account]
    client.accounts.delete(*, account_id) -> Optional[AccountDeleteResponse]
    client.accounts.get(*, account_id) -> Optional[Account]

Members

Types:

from cloudflare.types.accounts import Status, MemberDeleteResponse

Methods:

    client.accounts.members.create(*, account_id, **params) -> Optional[Member]
    client.accounts.members.update(member_id, *, account_id, **params) -> Optional[Member]
    client.accounts.members.list(*, account_id, **params) -> SyncV4PagePaginationArray[Member]
    client.accounts.members.delete(member_id, *, account_id) -> Optional[MemberDeleteResponse]
    client.accounts.members.get(member_id, *, account_id) -> Optional[Member]

Roles

Methods:

    client.accounts.roles.list(*, account_id, **params) -> SyncV4PagePaginationArray[Role]
    client.accounts.roles.get(role_id, *, account_id) -> Optional[Role]

Subscriptions

Types:

from cloudflare.types.accounts import SubscriptionDeleteResponse

Methods:

    client.accounts.subscriptions.create(*, account_id, **params) -> Subscription
    client.accounts.subscriptions.update(subscription_identifier, *, account_id, **params) -> Subscription
    client.accounts.subscriptions.delete(subscription_identifier, *, account_id) -> SubscriptionDeleteResponse
    client.accounts.subscriptions.get(*, account_id) -> SyncSinglePage[Subscription]

Tokens

Types:

from cloudflare.types.accounts import TokenCreateResponse, TokenDeleteResponse, TokenVerifyResponse

Methods:

    client.accounts.tokens.create(*, account_id, **params) -> Optional[TokenCreateResponse]
    client.accounts.tokens.update(token_id, *, account_id, **params) -> Optional[Token]
    client.accounts.tokens.list(*, account_id, **params) -> SyncV4PagePaginationArray[Token]
    client.accounts.tokens.delete(token_id, *, account_id) -> Optional[TokenDeleteResponse]
    client.accounts.tokens.get(token_id, *, account_id) -> Optional[Token]
    client.accounts.tokens.verify(*, account_id) -> Optional[TokenVerifyResponse]

PermissionGroups

Types:

from cloudflare.types.accounts.tokens import PermissionGroupListResponse, PermissionGroupGetResponse

Methods:

    client.accounts.tokens.permission_groups.list(*, account_id, **params) -> SyncSinglePage[PermissionGroupListResponse]
    client.accounts.tokens.permission_groups.get(*, account_id, **params) -> Optional[PermissionGroupGetResponse]

Value

Methods:

    client.accounts.tokens.value.update(token_id, *, account_id, **params) -> str

Logs
Audit

Types:

from cloudflare.types.accounts.logs import AuditListResponse

Methods:

    client.accounts.logs.audit.list(*, account_id, **params) -> SyncCursorPaginationAfter[AuditListResponse]

