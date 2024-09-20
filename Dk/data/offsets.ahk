class offsets
{
; 48 8B 0D ? ? ? ? 8B C5 48 C1 E8
static dwEntityList = 0x1F24888
; 48 63 C2 48 8D 0D ? ? ? ? 48 C1 E0
static dwViewMatrix = 0x20E21F0
; 48 8B 0D ? ? ? ? 48 85 C9 74 65 83 FF FF
static dwLocalPlayerPawn = 0x20D06D0
; 48 8D 3D ? ? ? ? 8B D9
static CCameraManager = 0x1F46170

;ControllerBase в CE отмотать 0x7b8 в поисках Dormant 1-жив 0-мертв, преобразовать в 4 байт целое
static m_bDormant = 0x7b8
;C_BaseEntity
static m_pGameSceneNode = 0x328
;ControllerBase в CE отмотать 0x7A0 в поисках хп, преобразовать в 4 байт целое
static m_ihealth = 0x7A0
static m_iMaxHealth = 0x768
;C_BaseEntity
static m_iTeamNum = 0x03eb
;CGameSceneNode
static m_vecAbsOrigin = 0xd0
;?
static m_boneArray = 0x80
;CBasePlayerController
static m_hPawn = 0x60c
;CSkeletonInstance
static m_modelState = 0x170
;C_BasePlayerPawn
static v_angle = 0x0E04
;CModelState
static m_hModel = 0xD0
;ControllerBase в CE отмотать 0x774 в поисках id, преобразовать в 4 байт целое
static m_heroid = 0x774
}





