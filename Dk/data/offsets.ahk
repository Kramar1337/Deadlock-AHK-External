class offsets
{
; 48 8B 0D ? ? ? ? 8B C5 48 C1 E8
static dwEntityList = 0x1F24948
; 48 63 C2 48 8D 0D ? ? ? ? 48 C1 E0
static dwViewMatrix = 0x20E22D0
; 48 8B 0D ? ? ? ? 48 85 C9 74 65 83 FF FF
static dwLocalPlayerPawn = 0x20D0668
; 48 8D 3D ? ? ? ? 8B D9
static CCameraManager = 0x1F46230

; localplayer->CPlayer_CameraServices->m_vecPunchAngle отдача
; C_BasePlayerPawn смещение
; static m_pCameraServices = 0xda0
; CPlayer_CameraServices
; static m_vecPunchAngle = 0x40
; static m_vecPunchAngleVel = 0x58

; CEntityInstance
; static m_bVisibleinPVS = 0x30
; STeamFOWEntity
; static m_bVisibleOnMap = 0x41

;ControllerBase в CE отмотать 0x7b8 в поисках Dormant 1-жив 0-мертв, преобразовать в 4 байт целое
static m_bDormant = 0x7b8
;C_BaseEntity
static m_pGameSceneNode = 0x328
;C_BaseEntity. старое: ControllerBase в CE отмотать 0x7A0 в поисках хп, преобразовать в 4 байт целое
static m_ihealth = 0x34c
static m_iMaxHealth = 0x348
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





