import rvp from '../../utils/responsive/Index'

@Component
export default struct Book {
  @Link visible: boolean

  build() {
    Row() {
      Column({ space: rvp(4) }) {
        Image($r('app.media.my_icon_1')).width(rvp(18))
        Text('99+').fontSize(rvp(12)).fontColor($r('app.color.gray'))
      }

      Column({ space: rvp(4) }) {
        Image($r('app.media.message')).width(rvp(18)).fillColor($r('app.color.black'))
        Text('咨询').fontSize(rvp(12)).fontColor($r('app.color.gray'))
      }

      Button('立即预定', { type: ButtonType.Normal })
        .borderRadius(rvp(2))
        .backgroundColor('#24A17B')
        .padding({ left: rvp(30), right: rvp(30) })
        .height(rvp(34))
        .onClick(() => {
          this.visible = true
        })

      Button('去看房', { type: ButtonType.Normal })
        .borderRadius(rvp(2))
        .backgroundColor('#6BE3BE')
        .padding({ left: rvp(30), right: rvp(30) })
        .height(rvp(34))
    }.backgroundColor($r('app.color.white')).height(rvp(50)).justifyContent(FlexAlign.SpaceEvenly).width('100%')
  }
}