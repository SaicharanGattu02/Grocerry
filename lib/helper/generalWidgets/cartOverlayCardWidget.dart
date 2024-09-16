import 'package:egrocer/helper/utils/generalImports.dart';

class CartOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          getSizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$1500',
                style: TextStyle(fontSize: 14, color: ColorsRes.mainTextColor),
              ),
              Text(
                '1 Items',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorsRes.subTitleMainTextColor,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            'Continue',
            style: TextStyle(
              fontSize: 14,
              color: ColorsRes.appColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // Close overlay
            },
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
