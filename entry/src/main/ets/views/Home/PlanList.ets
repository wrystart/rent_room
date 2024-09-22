import { IPlanItem, IPlanList } from '../../models/HomeData';
import rvp from '../../utils/responsive/Index';

@Component
export default struct PlanList {
  @Prop planList: IPlanList;

  build() {
    Row({ space: rvp(5) }) {
      ForEach(this.planList, (plan: IPlanItem) => {
        Image(plan.imageURL).width(rvp(78)).height(rvp(60)).objectFit(ImageFit.Fill)
      }, (plan: IPlanItem) => plan.id + '')
    }
    .width('100%')
    .margin({ top: rvp(18) })
  }
}