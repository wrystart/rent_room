import Card from '../../components/Card/Index'
import rvp from '../../utils/responsive/Index'

@Component
export default struct DomesticService {
  build() {
    Column() {
      Card() {
        // 默认插槽
        Text("DomesticService")
      }
    }
    .width('100%').margin({ top: rvp(43) })
  }
}