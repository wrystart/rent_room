import { sendSMSCodeApi } from '../../api/login';
import NavBar from '../../components/NavBar/Index';
import rvp from '../../utils/responsive/Index';


// interface IParams { phone: string }

@Entry
@Component
struct LoginCode {
  @StorageProp('topHeight') topHeight: number = 0
  // 初始化倒计时时间
  START_TIME = 61
  // 显示的时间
  @State time: number = this.START_TIME
  // 定时器的id
  timer = 0
  // 发送验证码
  sendSMSCode = () => {
    // const params = router.getParams() as IParams
    sendSMSCodeApi('15814056370')
    this.countDown()
  }
  // 倒计时功能
  countDown = () => {
    this.time--
    this.timer = setInterval(() => {
      this.time--
      if (this.time === 0) {
        clearInterval(this.timer)
        this.time = this.START_TIME
      }
    }, 1000)
  }

  aboutToAppear(): void {
    this.sendSMSCode()
  }

  aboutToDisappear(): void {
    clearInterval(this.timer)
  }

  build() {
    Column() {
      NavBar({ title: '验证码登录' })

      Column() {
        Stack() {
          TextInput({ placeholder: '请输入验证码' })
            .type(InputType.Number)
            .maxLength(6)
            .backgroundColor('rgba(0, 0, 0, 0)')
            .fontSize(rvp(16))
            .fontColor($r('app.color.black'))
            .placeholderColor('#C1C1C1')
            .placeholderFont({ size: rvp(16) })
            .border({
              width: {
                bottom: 1
              },
              color: '#C4EDCE'
            })
            .borderRadius(0)
            .padding({
              top: rvp(8),
              bottom: rvp(8),
              left: 0,
              right: 0
            })
            .caretColor($r('app.color.primary'))
          if (this.time === this.START_TIME) {
            Text('重新获取').fontSize(rvp(16)).fontColor($r('app.color.primary')).onClick(this.sendSMSCode)

          } else {
            Text(this.time + 's').fontSize(rvp(16)).fontColor($r('app.color.primary'))

          }
        }.width('100%').alignContent(Alignment.End)

        // if (this.isValidPhone && this.isAgree) {
        //   Button('确定')
        //     .width(rvp(100))
        //     .height(rvp(40))
        //     .margin({ top: rvp(40) })
        //     .alignSelf(ItemAlign.End)
        //     .backgroundColor($r('app.color.primary'))
        //     .onClick(() => {
        //       router.pushUrl({
        //         url: 'pages/Login/LoginCode',
        //         params: {
        //           phone: this.phone
        //
        //         }
        //       })
        //     })
        // } else {
        Button('确定')
          .width(rvp(100))
          .height(rvp(40))
          .margin({ top: rvp(40) })
          .alignSelf(ItemAlign.End)// .backgroundColor($r('app.color.primary'))
          .backgroundColor('#F0F0F0')
          .fontColor('#C1C1C1')
          .stateEffect(false)
        // }


      }.width('100%').padding({ left: rvp(37), right: rvp(37), top: rvp(40) })
    }
    .height('100%')
    .width('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#DEFBE5', 0], ['#FFFFFF', 0.3]]
    })
    .padding({ top: this.topHeight })
  }
}