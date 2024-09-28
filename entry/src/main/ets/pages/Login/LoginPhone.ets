import NavBar from '../../components/NavBar/Index';
import rvp from '../../utils/responsive/Index';

@Entry
@Component
struct LoginPhone {
  @StorageProp('topHeight') topHeight: number = 0

  build() {
    Column() {
      NavBar({ title: '验证码登录' })

      Column() {
        Stack() {
          TextInput({ placeholder: '请输入手机号', })
            .type(InputType.Number)
            .maxLength(11)
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

          Image($r('app.media.success')).width(rvp(12)).height(rvp(8))
        }.width('100%').alignContent(Alignment.End)

        Row({ space: rvp(6) }) {
          Checkbox()
            .selectedColor($r('app.color.primary'))
            .width(rvp(14))
            .height(rvp(14))

          Text() {
            Span('同意').fontColor('#C1C1C1')
            Span('《用户协议》').fontColor($r('app.color.primary'))
            Span('和').fontColor('#C1C1C1')
            Span('《隐私政策》').fontColor($r('app.color.primary'))
          }.fontSize(rvp(12))
        }.width('100%').margin({ top: rvp(16) })

        Button('获取验证码')
          .width(rvp(100))
          .height(rvp(40))
          .margin({ top: rvp(40) })
          .alignSelf(ItemAlign.End)// .backgroundColor($r('app.color.primary'))
          .backgroundColor('#F0F0F0')
          .fontColor('#C1C1C1')
          .stateEffect(false)

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