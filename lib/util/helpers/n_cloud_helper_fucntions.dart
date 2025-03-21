import 'package:flutter/material.dart';

class NCloudHelperFunctions {
  NCloudHelperFunctions._();

  static Widget? checkMultiRecordState<T>(
      {required AsyncSnapshot<List<T>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if(!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty){
      if(nothingFound != null) return nothingFound;
      return const Center(child: Text('No Data found'),);
    }
    if(snapshot.hasError){
      if(error != null) return error;
      return const Center(child: Text('SomeThing went wrong'),);
    }
    return null;
  }
}
