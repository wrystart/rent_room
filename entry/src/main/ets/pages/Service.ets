import ScrollContainer from '../components/ScrollContainer/Index'
import Bg from '../views/Service/Bg'

@Component
export default struct Service {
  @Builder
  navBuilder() {

  }

  @Builder
  contentBuilder() {
    Stack(){
        Bg()
    }.width('100%')
  }

  build() {
    ScrollContainer({
      navBuilderParam: this.navBuilder,
      contentBuilderParam: () => {
        this.contentBuilder()
      }
    })
  }
}