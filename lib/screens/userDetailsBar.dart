// ignore_for_file: prefer_const_constructors
import 'package:amazon/state/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amazon/constants/colors.dart';
import 'package:amazon/models/userDetailsModel.dart';
import 'package:flutter/material.dart';

class UserDetailBar extends ConsumerWidget {
  final double offset;

  const UserDetailBar({
    super.key,
    this.offset = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
    Size size = MediaQuery.of(context).size;
    return Positioned(
      top: -offset / 3,
      child: Container(
        height: 80 / 2,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColor.lightBackgroundaGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 20,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey[900],
                ),
              ),
              SizedBox(
                width: size.width * 0.7,
                child: Consumer(builder: (context, ref, child) {
                  final text = ref.watch(getNameAndAddress);
                  return text.when(data: (data) {
                    return Text(
                      "Deliver to ${data!.name} - ${data.address}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[900],
                      ),
                    );
                  }, error: (e, StackTrace err) {
                    return Text(
                      "Deliver to ${err}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[900],
                      ),
                    );
                  }, loading: () {
                    return Text(
                      "Deliver to lo - loading",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[900],
                      ),
                    );
                  });
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
